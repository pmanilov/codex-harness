#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
codex_skill_home="$codex_home/skills"
agents_skill_home="$HOME/.agents/skills"
skill_homes=("$codex_skill_home" "$agents_skill_home")
stamp="$(date +%Y%m%d%H%M%S)"
install_skills=true
install_agents=true
install_config=true
install_rules=true
dry_run=false
selected_skills=()

usage() {
  cat <<'EOF'
Usage: scripts/install.sh [options]

Options:
  --skills-only       Install skills only; skip AGENTS.md and config.
  --skill NAME        Install only one skill. Can be repeated.
  --no-skills         Skip skill installation.
  --no-agents         Skip linking global/AGENTS.md.
  --no-config         Skip config.example.toml bootstrap.
  --no-rules          Skip linking portable Codex rules.
  --dry-run           Print actions without changing files.
  -h, --help          Show this help.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --skills-only)
      install_skills=true
      install_agents=false
      install_config=false
      install_rules=false
      ;;
    --skill)
      if [ "$#" -lt 2 ]; then
        printf 'Missing value for --skill\n' >&2
        exit 2
      fi
      selected_skills+=("$2")
      shift
      ;;
    --no-skills)
      install_skills=false
      ;;
    --no-agents)
      install_agents=false
      ;;
    --no-config)
      install_config=false
      ;;
    --no-rules)
      install_rules=false
      ;;
    --dry-run)
      dry_run=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [ "$install_skills" = false ] && [ "${#selected_skills[@]}" -gt 0 ]; then
  printf 'Cannot use --skill when --no-skills is set\n' >&2
  exit 2
fi

run_cmd() {
  if [ "$dry_run" = true ]; then
    printf 'DRY RUN:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

backup_existing() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    run_cmd mv "$target" "${target}.bak.${stamp}"
    printf 'Backed up %s\n' "$target"
  fi
}

link_path() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    printf 'Already linked %s -> %s\n' "$target" "$source"
    return
  fi

  backup_existing "$target"
  run_cmd ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

if [ "$install_agents" = true ] || [ "$install_config" = true ] || [ "$install_rules" = true ]; then
  run_cmd mkdir -p "$codex_home"
fi

if [ "$install_skills" = true ]; then
  for skill_home in "${skill_homes[@]}"; do
    run_cmd mkdir -p "$skill_home"
  done

  install_skill() {
    local skill_name="$1"
    local skill_dir="$repo_dir/skills/$skill_name"
    if [ ! -f "$skill_dir/SKILL.md" ]; then
      printf 'Skill not found or missing SKILL.md: %s\n' "$skill_name" >&2
      exit 1
    fi
    for skill_home in "${skill_homes[@]}"; do
      link_path "$skill_dir" "$skill_home/$skill_name"
    done
  }

  if [ "${#selected_skills[@]}" -gt 0 ]; then
    for skill_name in "${selected_skills[@]}"; do
      install_skill "$skill_name"
    done
  else
    for skill_dir in "$repo_dir"/skills/*; do
      [ -d "$skill_dir" ] || continue
      [ -f "$skill_dir/SKILL.md" ] || continue
      skill_name="$(basename "$skill_dir")"
      install_skill "$skill_name"
    done
  fi
else
  printf 'Skipped skills\n'
fi

if [ "$install_agents" = true ]; then
  link_path "$repo_dir/global/AGENTS.md" "$codex_home/AGENTS.md"
else
  printf 'Skipped AGENTS.md\n'
fi

if [ "$install_config" = true ]; then
  if [ ! -e "$codex_home/config.toml" ] && [ ! -L "$codex_home/config.toml" ]; then
    run_cmd cp "$repo_dir/config/config.example.toml" "$codex_home/config.toml"
    printf 'Created %s from config/config.example.toml\n' "$codex_home/config.toml"
  else
    printf 'Left existing %s unchanged\n' "$codex_home/config.toml"
  fi
else
  printf 'Skipped config\n'
fi

if [ "$install_rules" = true ]; then
  run_cmd mkdir -p "$codex_home/rules"
  for rule_file in "$repo_dir"/rules/*.rules; do
    [ -f "$rule_file" ] || continue
    rule_name="$(basename "$rule_file")"
    link_path "$rule_file" "$codex_home/rules/$rule_name"
  done
else
  printf 'Skipped rules\n'
fi
