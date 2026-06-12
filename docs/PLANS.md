# Plans

Use this workflow for complex or cross-cutting harness changes.

## Planning Workflow

- Inspect `AGENTS.md`, relevant `docs/`, scripts, config templates, and skill files before proposing changes.
- Separate portable repo state from local Codex state. Repo changes belong here; tokens, live configs, sessions, caches, and machine-specific trust entries do not.
- Prefer small harness primitives: concise `AGENTS.md`, focused skills, explicit install behavior, and deterministic validation.
- Choose scripts only when repeatability is worth the maintenance cost.
- Add Codex rules only for narrow, repeated mistakes that should be mechanically enforced.

## Definition Of Done

- The repo remains the source of truth for portable Codex harness files.
- Existing local config is not overwritten by install behavior.
- New skills validate through `scripts/check.sh` and have matching `agents/openai.yaml` metadata.
- Portable rules install without replacing local `default.rules`.
- Documentation reflects changed install paths, validation commands, or workflow rules.
- `bash scripts/check.sh`, `git diff --check`, and `git status --short` are reviewed before finishing.
