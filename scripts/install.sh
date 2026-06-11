#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
skill_home="$HOME/.agents/skills"
stamp="$(date +%Y%m%d%H%M%S)"

backup_existing() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "${target}.bak.${stamp}"
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
  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

mkdir -p "$codex_home" "$skill_home"

for skill_dir in "$repo_dir"/skills/*; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue
  skill_name="$(basename "$skill_dir")"
  link_path "$skill_dir" "$skill_home/$skill_name"
done

link_path "$repo_dir/global/AGENTS.md" "$codex_home/AGENTS.md"

if [ ! -e "$codex_home/config.toml" ] && [ ! -L "$codex_home/config.toml" ]; then
  cp "$repo_dir/config/config.example.toml" "$codex_home/config.toml"
  printf 'Created %s from config/config.example.toml\n' "$codex_home/config.toml"
else
  printf 'Left existing %s unchanged\n' "$codex_home/config.toml"
fi
