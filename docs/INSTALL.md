# Install

## First Machine

The current repository is initialized from existing local Codex state:

- user skills from `/home/pavel/.codex/skills/plan-deeply` and `/home/pavel/.codex/skills/ralph-loop`;
- global guidance from `/home/pavel/.codex/AGENTS.md`;
- a sanitized config template derived from `/home/pavel/.codex/config.toml`.

## Second Machine

Clone this repository, then run:

```bash
cd ~/codex-harness
bash scripts/check.sh
bash scripts/install.sh
```

The installer links skills into `$HOME/.agents/skills` and links global guidance into `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`.

If `${CODEX_HOME:-$HOME/.codex}/config.toml` does not exist, the installer creates it from `config/config.example.toml`. If it already exists, the installer leaves it unchanged.

## Partial Install

Use partial installs when a device needs different global guidance or local config.

Install only skills and leave that machine's `AGENTS.md` and `config.toml` unchanged:

```bash
bash scripts/install.sh --skills-only
```

Install one skill only:

```bash
bash scripts/install.sh --skills-only --skill ralph-loop
```

Install skills and config bootstrap, but keep a device-specific `AGENTS.md`:

```bash
bash scripts/install.sh --no-agents
```

Preview changes without touching the filesystem:

```bash
bash scripts/install.sh --dry-run
```

## Updating

Use normal Git flow:

```bash
git pull
bash scripts/check.sh
bash scripts/install.sh --skills-only
```

When editing a skill, edit the repo copy in `skills/`. The symlinked install makes the change visible to Codex without copying files.

Restart Codex if a changed skill or global instruction does not appear in a running session.
