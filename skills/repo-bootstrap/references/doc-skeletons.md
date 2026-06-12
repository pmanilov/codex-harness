# Repo Bootstrap Doc Skeletons

Use these skeletons as concise targets. Omit sections that are not supported by repository facts.

## AGENTS.md

```md
# AGENTS.md

## Knowledge Map

- Read `docs/ARCHITECTURE.md` before changing module boundaries or data flow.
- Read `docs/TESTING.md` before running validation or changing test setup.
- Read `docs/QUALITY.md` before broad refactors or cross-cutting changes.
- Read `docs/EVALS.md` before changing critical user flows.
- Read `docs/PLANS.md` before planning complex work.

## Repository Rules

- Keep guidance repo-specific and concise.
- Put durable details in `docs/`; keep this file navigational.
- Preserve existing behavior unless the task explicitly changes it.

## Verification

- Run `<exact discovered command>` after relevant changes.
- Run `git diff --check` before finishing docs-only changes.
```

## docs/ARCHITECTURE.md

```md
# Architecture

## System Shape

- `<facts from README/manifests/entrypoints>`

## Layout

- `<directory>`: `<role>`

## Data Flow

- `<input/state/output flow supported by code>`

## Boundaries

- `<module ownership, public interfaces, generated files, or do-not-edit areas>`

## Known Gaps

- `<missing facts, not guesses>`
```

## docs/TESTING.md

```md
# Testing

Run from the repository root: `<exact command>`

## When To Run

- `<command>` after `<change type>`.

## Notes

- `<known skipped checks, required services, fixtures, or gaps>`
```

## docs/QUALITY.md

```md
# Quality

## Principles

- `<durable engineering principle grounded in the repo>`

## Do Not Rules

- `<specific risky pattern to avoid>`

## Documentation Upkeep

- Update `<doc>` when `<code/config behavior>` changes.
```

## docs/EVALS.md

```md
# Evals

## Critical Flows

- `<flow>`: expected behavior and relevant tests/checks.

## Regression Scenarios

- `<scenario>` should continue to `<observable result>`.

## Known Gaps

- `<manual checks or missing coverage>`
```

## docs/PLANS.md

```md
# Plans

## Planning Workflow

- Gather repository facts before asking product questions.
- Resolve high-impact behavior, interface, migration, and validation decisions before implementation.

## Definition Of Done

- Code/docs changed within scope.
- Relevant checks pass or blocked checks are reported.
- Diff reviewed for unrelated changes.
```
