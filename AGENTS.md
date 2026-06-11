# AGENTS.md

## Knowledge Map

- Read `docs/ARCHITECTURE.md` before changing repository layout or install behavior.
- Read `docs/TESTING.md` before validating skills, scripts, or sync changes.
- Read `docs/QUALITY.md` before adding portable Codex customizations.
- Read `docs/INSTALL.md` when changing two-device setup, symlinks, or bootstrap steps.

## Repository Rules

- Keep this repo as the portable source of truth for personal Codex harness files.
- Do not commit live Codex state: auth, sqlite databases, logs, sessions, cache, generated images, tmp directories, or bundled `.system` skills.
- Put reusable workflows in `skills/`.
- Put global personal guidance in `global/AGENTS.md`.
- Keep machine-specific config in local `~/.codex/config.toml`; only portable examples belong in `config/`.
- Keep this file short. Move durable details into `docs/`.

## Verification

- Run `bash scripts/check.sh` after changing skills, scripts, docs, or config templates.
- Run `git diff --check` before finishing.
- Stage only task-related files with explicit `git add -- <paths>`.
