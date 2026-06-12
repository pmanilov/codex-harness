# Architecture

This repository stores portable personal Codex harness files. It is not a mirror of `~/.codex`.

## Layout

- `skills/`: user-authored skills that can be symlinked into Codex user skill discovery paths.
- `global/AGENTS.md`: personal global Codex guidance.
- `config/config.example.toml`: portable config defaults without trusted project paths or secrets.
- `rules/`: portable Codex command policy rules.
- `scripts/install.sh`: symlink installer for a local machine.
- `scripts/check.sh`: structural and safety validation.
- `docs/`: durable notes for agents maintaining this harness.

## Boundaries

Keep out of git:

- `auth.json`, tokens, secrets, `.env` files.
- `history.jsonl`, logs, sessions, shell snapshots.
- sqlite state, cache, tmp, generated images, memories.
- bundled system skills from `.codex/skills/.system`.

## Data Flow

The repo is the source of truth. `scripts/install.sh` links portable files into Codex discovery paths:

- `skills/<name>` -> `${CODEX_HOME:-$HOME/.codex}/skills/<name>`
- `skills/<name>` -> `$HOME/.agents/skills/<name>`
- `global/AGENTS.md` -> `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`
- `rules/*.rules` -> `${CODEX_HOME:-$HOME/.codex}/rules/*.rules`

The installer copies `config/config.example.toml` only when no local Codex config exists. Local machine config remains local after that.
