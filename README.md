# Codex Harness

Portable personal Codex harness for syncing user-owned skills, global guidance, and safe config defaults across machines.

This repository is the source of truth. It is not a mirror of `~/.codex`.

## Contents

- `skills/`: personal Codex skills.
- `global/AGENTS.md`: personal global guidance.
- `config/config.example.toml`: portable config template without local trusted-project paths.
- `rules/`: portable Codex command policy rules.
- `scripts/install.sh`: symlink installer.
- `scripts/check.sh`: repository validation.
- `docs/`: maintenance notes for future agents.

## Install

Full install:

```bash
bash scripts/check.sh
bash scripts/install.sh
```

Skills only, keeping device-specific `AGENTS.md` and config:

```bash
bash scripts/install.sh --skills-only
```

One skill only:

```bash
bash scripts/install.sh --skills-only --skill ralph-loop
```

Preview without changing files:

```bash
bash scripts/install.sh --dry-run
```

See `docs/INSTALL.md` for the full install workflow.

## Safety

Do not commit live Codex state: auth files, sqlite databases, sessions, logs, cache, generated images, tmp directories, memories, or bundled `.system` skills.

Run before committing:

```bash
bash scripts/check.sh
git diff --check
git status --short
```

## MCP

The portable config template includes OpenAI Docs MCP and Context7. GitHub MCP is intentionally omitted; use `gh` or add GitHub MCP locally only when a workflow needs it.
