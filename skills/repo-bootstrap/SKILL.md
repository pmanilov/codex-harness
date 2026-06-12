---
name: repo-bootstrap
description: Create or refresh repository-level Codex harness docs from discovered repo facts. Use when asked to bootstrap agent guidance, initialize or update AGENTS.md, create lightweight docs such as ARCHITECTURE/TESTING/QUALITY/EVALS/PLANS, or make a repository ready for reliable Codex work.
---

# Repo Bootstrap

Use this skill to create or refresh concise repository guidance for Codex. Ground every file in repository facts; do not invent architecture, commands, deployment, ownership, or policy details.

## Workflow

1. Inspect before writing:
   - Read the nearest `AGENTS.md` first if it exists.
   - Inspect `README*`, package/build manifests, test configs, CI files, scripts, entrypoints, migrations, deployment files, and existing `docs/`.
   - Use targeted `rg` / `rg --files` searches. Do not ask the user for facts that are discoverable locally.

2. Decide the documentation set:
   - Ensure a short root `AGENTS.md` exists for Codex instructions and navigation.
   - Create or update `docs/ARCHITECTURE.md`, `docs/TESTING.md`, `docs/QUALITY.md`, `docs/EVALS.md`, and `docs/PLANS.md` when missing or stale.
   - Add domain docs only when repo facts justify them, such as `docs/API.md`, `docs/DEPLOYMENT.md`, `docs/SECURITY.md`, `docs/DATABASE.md`, or integration-specific docs.
   - Merge with existing useful guidance instead of replacing it wholesale.

3. Keep the root `AGENTS.md` navigational:
   - Include a knowledge map that tells agents which `docs/*.md` file to read for each task type.
   - Include documentation upkeep rules and exact verification commands.
   - Keep durable architecture, commands, invariants, and review rules in `docs/` rather than expanding `AGENTS.md`.

4. Write docs from evidence:
   - Use exact commands only when found in manifests, scripts, CI, Makefiles, or existing docs.
   - Record unknowns as concise "Known gaps" instead of guessing.
   - Prefer short, scannable sections that help future agents act correctly.
   - Preserve project-specific rules in the repo, not in global Codex guidance.

5. Validate and report:
   - Run the repository's docs or harness checks when available.
   - Always run `git diff --check` for docs-only bootstrap work.
   - Review the diff for unrelated changes before finishing.
   - If new files were created and staging is requested by active instructions, stage only task-created files with explicit paths.

## Reference

Read `references/doc-skeletons.md` before drafting new docs or restructuring existing guidance. Use it as a compact shape guide, not as text to copy blindly.

## Edge Cases

- If the current directory is not a repository and no target path is clear, ask for the repository path.
- In monorepos, keep root `AGENTS.md` shared and add nested `AGENTS.md` files only for subtrees with materially different commands or rules.
- If a closer `AGENTS.override.md` exists, treat it as higher-precedence local guidance and avoid overwriting it unless explicitly requested.
- Do not include secrets, live local state, tokens, generated caches, logs, sessions, or machine-specific absolute paths unless the repository already documents them as portable examples.
