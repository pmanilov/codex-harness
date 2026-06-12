# Quality

## Principles

- Prefer portable source files over snapshots of live Codex state.
- Keep each skill focused and concise; move optional detail into `references/`.
- Use scripts only when deterministic behavior is worth the maintenance cost.
- Keep config examples safe to share across devices.
- Treat install behavior as conservative: backup existing files, do not overwrite local config, and do not touch unrelated Codex state.
- Enforce high-risk repeated mistakes with narrow Codex rules instead of relying only on prose.

## Do Not Rules

- Do not commit secrets, auth files, local histories, sqlite databases, logs, or cache directories.
- Do not vendor bundled `.system` skills.
- Do not add machine-specific trusted project paths to `config/config.example.toml`.
- Do not make `~/.codex` itself the git source of truth.
- Do not weaken skill validation to make checks pass.
- Do not use broad staging commands such as `git add .`, `git add -A`, or `git add --all`.

## Documentation Upkeep

- Update `docs/ARCHITECTURE.md` when the repo layout or install targets change.
- Update `docs/TESTING.md` when validation commands change.
- Update `docs/INSTALL.md` when bootstrap behavior changes.
- Update `docs/EVALS.md` when critical harness workflows change.
- Update `docs/PLANS.md` when planning workflow or definition of done changes.
- Keep `AGENTS.md` navigational and move durable detail here.
