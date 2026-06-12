#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

required_paths=(
  ".gitignore"
  "AGENTS.md"
  "README.md"
  "global/AGENTS.md"
  "config/config.example.toml"
  "rules/harness.rules"
  "docs/ARCHITECTURE.md"
  "docs/EVALS.md"
  "docs/PLANS.md"
  "docs/TESTING.md"
  "docs/QUALITY.md"
  "docs/INSTALL.md"
  "scripts/install.sh"
  "scripts/check.sh"
  "skills/plan-deeply/SKILL.md"
  "skills/repo-bootstrap/SKILL.md"
  "skills/ralph-loop/SKILL.md"
)

for path in "${required_paths[@]}"; do
  if [ ! -e "$path" ]; then
    printf 'Missing required path: %s\n' "$path" >&2
    exit 1
  fi
done

for skill_md in skills/*/SKILL.md; do
  python3 - "$skill_md" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text()
match = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
if not match:
    raise SystemExit(f"{path}: missing YAML frontmatter")

data = {}
for raw in match.group(1).splitlines():
    line = raw.strip()
    if not line:
        continue
    if ":" not in line:
        raise SystemExit(f"{path}: invalid frontmatter line: {raw}")
    key, value = line.split(":", 1)
    key = key.strip()
    value = value.strip().strip('"').strip("'")
    data[key] = value

name = data.get("name", "")
description = data.get("description", "")
if not re.fullmatch(r"[a-z0-9-]+", name):
    raise SystemExit(f"{path}: invalid skill name: {name!r}")
if not description:
    raise SystemExit(f"{path}: missing description")
if len(description) > 1024:
    raise SystemExit(f"{path}: description too long")
PY
done

forbidden="$(find . \
  -path './.git' -prune -o \
  \( \
    -name 'auth.json' -o \
    -name 'history.jsonl' -o \
    -name 'installation_id' -o \
    -name '*.sqlite' -o \
    -name '*.sqlite-shm' -o \
    -name '*.sqlite-wal' -o \
    -name '.env' -o \
    -name '.env.*' -o \
    -path './cache/*' -o \
    -path './log/*' -o \
    -path './logs/*' -o \
    -path './sessions/*' -o \
    -path './tmp/*' -o \
    -path './.tmp/*' -o \
    -path './generated_images/*' \
  \) -print)"

if [ -n "$forbidden" ]; then
  printf 'Forbidden local-state files found:\n%s\n' "$forbidden" >&2
  exit 1
fi

if command -v rg >/dev/null 2>&1; then
  rg -n "^(<<<<<<<|=======|>>>>>>>)" . && exit 1 || true
  rg -n "[[:blank:]]+$" . && exit 1 || true
else
  grep -RInE "^(<<<<<<<|=======|>>>>>>>)" . && exit 1 || true
fi

validator="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
if [ -f "$validator" ]; then
  for skill_dir in skills/*; do
    [ -d "$skill_dir" ] || continue
    if python3 -c 'import yaml' >/dev/null 2>&1; then
      python3 "$validator" "$skill_dir"
    else
      printf 'Skipped quick_validate.py for %s: Python module yaml is not installed\n' "$skill_dir"
    fi
  done
fi

bash scripts/install.sh --dry-run >/dev/null
bash scripts/install.sh --skills-only --dry-run >/dev/null
bash scripts/install.sh --skills-only --skill repo-bootstrap --dry-run >/dev/null
bash scripts/install.sh --skills-only --skill ralph-loop --dry-run >/dev/null
bash scripts/install.sh --no-agents --dry-run >/dev/null
bash scripts/install.sh --no-skills --no-agents --no-config --dry-run >/dev/null

printf 'Harness checks passed\n'
