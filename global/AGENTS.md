# AGENTS.md

## Git workflow

- After making code changes, run the relevant tests or checks before the final response.
- If Codex created new files for the current task, stage only those new task files with explicit path-based `git add -- <paths>`.
- Do not use `git add .`.
- Do not stage unrelated modified files, generated artifacts, secrets, local env files, logs, or dependency/build directories.
- After verification, include a concise commit message in the final response.
- Follow the nearest project `AGENTS.md` for commit-message format. Keep project-specific commit conventions in local project instructions, not in this global file.

## Planning and completion

- For complex or ambiguous tasks, gather repository context first, then propose or follow a plan before implementation.
- Good task framing includes goal, context, constraints, and clear "done when" criteria.
- Before finishing implementation work, review the diff for unrelated changes and report any checks that could not be run.

## Repository context discipline

- Read the nearest project `AGENTS.md` before implementation. Project instructions override global instructions when they are more specific.
- Prefer targeted discovery over broad reads: use `rg` / `rg --files`, inspect manifests/configs/entrypoints/tests first, then open only relevant files.
- Do not ask the user for facts that can be discovered from the repository; ask only for product intent, preferences, or tradeoffs.
- When creating or updating project harness docs, merge with existing guidance instead of overwriting useful local rules.
- Keep global instructions generic. Put project-specific architecture, commands, invariants, and workflows in the repository `AGENTS.md` and `docs/*.md`.

## New project harness setup

- When starting or planning a new repository/project, check whether the repo has project-level agent guidance and a lightweight knowledge base.
- If missing, propose creating:
  - `AGENTS.md`: short repo-specific instruction map for Codex.
  - `docs/ARCHITECTURE.md`: system shape, module boundaries, data flow, ownership, public interfaces.
  - `docs/TESTING.md`: exact build/test/lint commands, when to run each, known gaps.
  - `docs/QUALITY.md`: durable engineering principles, invariants, review feedback, do-not rules.
  - `docs/EVALS.md`: critical user flows/regression scenarios, expected behavior, relevant tests.
  - `docs/PLANS.md`: project-specific planning workflow, acceptance criteria, definition of done.
- Create domain-specific docs only when the project needs them, for example:
  - `docs/TELEGRAM.md` for Telegram bots/integrations.
  - `docs/API.md` for public APIs or SDKs.
  - `docs/DEPLOYMENT.md` for deployment-heavy projects.
  - `docs/SECURITY.md` for auth, permissions, secrets, or sensitive data flows.
- Ensure project `AGENTS.md` includes:
  - a short knowledge map that tells agents which `docs/*.md` file to read for each kind of task;
  - project-specific Git workflow and commit-message format, if the project has one;
  - documentation upkeep rules for when code changes must update docs;
  - a reminder to keep `AGENTS.md` short and move durable details into `docs/`.
- Fill each file from repository facts, not guesses:
  - inspect package manifests, build files, migrations, tests, configs, entrypoints, and README first;
  - keep docs concise and navigational;
  - put project-specific rules in repo `AGENTS.md`, not in the global file;
  - update docs when code changes make them stale.
- For docs-only setup, run `git diff --check`. If files are created, stage only task-created files explicitly with `git add -- <paths>`.
