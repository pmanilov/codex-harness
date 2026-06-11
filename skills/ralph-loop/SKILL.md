---
name: ralph-loop
description: Run bounded Ralph/CRDAL-style iterative agent loops for software tasks: define external validation, attempt a change, run checks, analyze feedback and progress, perform metacognitive review, and repeat until success or budget. Use when the user asks for Ralph loop, ralphing, iterative self-improvement, external-validation loops, validation-driven task loops, or guarded AFK-style task iteration.
---

# Ralph Loop

## Overview

Use this skill to run a bounded validation-driven loop: attempt, externally validate, analyze feedback, review strategy, and retry until success or an explicit stop condition.

Default to CRDAL-lite: keep one acting agent, but add a separate reviewer-style strategy pass after each validation result. Never treat model confidence as success; success must come from an external validator or explicit user acceptance criteria.

For source-grounded definitions of Ralph, RWL, SRL, CRDAL, and loop templates, read `references/ralph-patterns.md` when the user asks what Ralph means, wants a loop variant, the loop stalls, or source-backed rationale matters.

## Start The Loop

Before the first iteration, establish:

- Goal: the concrete outcome requested by the user.
- Acceptance: observable success criteria.
- Validator: tests, builds, lint/type checks, smoke checks, screenshots, command output, or explicit manual acceptance.
- Safety scope: default to local-only guarded execution.
- Budget: default to 5 iterations for normal coding tasks and 2 iterations for risky tasks unless the user sets a different budget.

If a validator is missing, derive the narrowest relevant check from the repo. Ask only when success cannot be safely inferred from local context.

Initialize a compact ledger:

```text
Loop: <goal>
Validator: <commands or acceptance checks>
Budget: <max iterations>
Safety: local-only guarded

| Iter | Action | Validation | Progress | Review | Next |
```

## Iterate

For each iteration:

1. Make one focused attempt toward the goal.
2. Run the validator and capture the material result.
3. Classify progress as `improving`, `stalling`, or `regressing`.
4. Perform a CRDAL-lite review pass:
   - identify the current bottleneck;
   - identify whether the agent is fixating on one approach;
   - propose the next smallest strategy change;
   - flag any safety or approval boundary.
5. Append one ledger row and either continue or stop.

Use a subagent for the reviewer pass only when the user explicitly authorizes subagents and the active tool rules allow it. Otherwise, perform the reviewer pass locally, separated from the acting step.

## Stop Conditions

Stop the loop when any condition is true:

- Acceptance criteria pass.
- The iteration budget is exhausted.
- The same blocker repeats for 3 consecutive loop turns.
- Required validation cannot be run or trusted.
- The next step requires destructive, external, secret-bearing, deployment, or production-affecting action without approval.
- The user interrupts, changes scope, or asks for a report.

When stopping without success, report the blocker, the last validator result, and the smallest useful next action.

## Safety Defaults

Use local-only guarded execution unless the user explicitly broadens scope:

- Do not deploy, publish, push, or write to external systems.
- Do not access secrets or production data.
- Do not run destructive commands such as broad `rm`, `git reset`, or database-changing commands without explicit approval.
- Do not hide validation failures by weakening tests, deleting coverage, fabricating data, or changing acceptance criteria.
- Respect the active collaboration mode; in Plan Mode, produce a loop plan only and do not mutate files.

## Completion Report

End with:

- final outcome;
- iterations used;
- validators run and whether they passed;
- unresolved validation gaps or stop reasons;
- changed files and concise commit message when code changed.
