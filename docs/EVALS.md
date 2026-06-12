# Evals

Use these scenarios to catch regressions in the harness itself.

## Critical Flows

- Full validation: `bash scripts/check.sh` should pass from the repository root.
- Docs-only validation: `git diff --check` should pass after documentation changes.
- Skill install preview: `bash scripts/install.sh --skills-only --dry-run` should show symlinks into both Codex skill discovery paths.
- Single-skill install preview: `bash scripts/install.sh --skills-only --skill repo-bootstrap --dry-run` should target only `repo-bootstrap`.
- Rules install preview: `bash scripts/install.sh --no-skills --no-agents --no-config --dry-run` should target only portable rules.

## Regression Scenarios

- Existing local config is preserved: `bash scripts/install.sh --dry-run` should report that an existing `${CODEX_HOME:-$HOME/.codex}/config.toml` is left unchanged.
- Local Codex state stays out of git: `bash scripts/check.sh` should fail if auth, logs, sqlite, sessions, cache, tmp, or generated image files are added.
- Skill validation remains strict: every `skills/*/SKILL.md` needs YAML frontmatter with a lowercase hyphenated `name` and non-empty `description`.
- Broad staging stays blocked: `codex execpolicy check --pretty --rules rules/harness.rules -- git add .` should return `forbidden`.

## Known Gaps

- `quick_validate.py` runs only when Python `yaml` is installed.
- The harness does not automatically verify MCP server startup; use `codex mcp list` locally after config changes.
