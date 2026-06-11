# Architecture

This repository stores portable personal Codex harness files. It is not a mirror of `~/.codex`.

## Layout

- `skills/`: user-authored skills that can be symlinked into `$HOME/.agents/skills`.
- `global/AGENTS.md`: personal global Codex guidance.
- `config/config.example.toml`: portable config defaults without trusted project paths or secrets.
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

- `skills/<name>` -> `$HOME/.agents/skills/<name>`
- `global/AGENTS.md` -> `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`

The installer copies `config/config.example.toml` only when no local Codex config exists. Local machine config remains local after that.
