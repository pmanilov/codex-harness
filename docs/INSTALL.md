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

The installer links skills into both `${CODEX_HOME:-$HOME/.codex}/skills` and `$HOME/.agents/skills`, links global guidance into `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`, and links portable rules into `${CODEX_HOME:-$HOME/.codex}/rules`.

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

Install only portable rules:

```bash
bash scripts/install.sh --no-skills --no-agents --no-config
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

## MCP

The config template includes:

- `openaiDeveloperDocs`: official OpenAI developer documentation.
- `context7`: up-to-date third-party library documentation through `npx`.

Existing local `config.toml` files are not overwritten. Add or update MCP entries locally with `codex mcp add` when bootstrapping a machine that already has a config.
