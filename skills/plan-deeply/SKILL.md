---
name: plan-deeply
description: Produce adaptive, decision-complete implementation plans for complex or ambiguous software tasks. Use when the user asks for a detailed plan, implementation plan, execution plan, Plan mode output, project plan, task breakdown, or says a plan is too high-level. Do not use for simple factual answers, direct implementation requests without planning, status updates, or code review unless the user explicitly asks for a plan.
---

# Plan Deeply

Use this skill to turn fuzzy or high-risk work into an implementation plan that another engineer or agent can execute without making hidden product or technical decisions.

## Operating Principles

- Ground the plan in repository facts first. Inspect relevant files, manifests, tests, schemas, docs, and entrypoints before asking questions.
- Ask only for product intent, scope, constraints, or tradeoffs that cannot be discovered locally.
- Make the plan decision-complete: include the exact default choices, interfaces, expected behavior, tests, and acceptance criteria needed to implement safely.
- Match depth to risk. Keep simple tasks compact; expand for cross-module changes, migrations, public APIs, data contracts, security, payments, auth, or ambiguous product behavior.
- Prefer verification over confidence. Include concrete checks and call out assumptions, unknowns, and validation gaps.
- Do not reveal hidden chain of thought. Provide concise rationale, decisions, and implementation detail that help execution.

## Workflow

1. Establish the requested outcome, audience, constraints, and definition of done.
2. Gather enough local context to avoid planning from guesses.
3. Identify remaining high-impact ambiguities and resolve them before finalizing the plan. If the active mode supports structured user questions, use it.
4. Choose the plan depth:
   - Compact for one-file or low-risk edits.
   - Standard for normal feature work or refactors.
   - Deep for ambiguous, multi-system, public-interface, data, migration, security, or rollout-sensitive work.
5. Produce the final plan in the format required by the active instructions. If a wrapper such as `<proposed_plan>` is required, use it exactly.
6. Before finalizing, check that the implementer will not need to choose behavior, interfaces, test scope, or rollout policy.

## Plan Content

Include the sections that are relevant to the task. Do not include filler sections.

- Title: name the concrete outcome.
- Summary: state the goal, current state, and target behavior in a few sentences.
- Key decisions: list defaults chosen, rejected alternatives when material, and why the chosen path fits the repo.
- Public interfaces: specify API endpoints, CLI flags, config keys, schemas, types, events, migrations, or UI contracts that change.
- Implementation changes: group by subsystem or behavior, not by a long file inventory unless file names prevent ambiguity.
- Data flow: describe how inputs move through the system and where state is read, written, cached, validated, or invalidated.
- Edge cases and failures: include permission, validation, compatibility, idempotency, concurrency, rollback, or degraded-mode behavior when relevant.
- Test plan: name the unit, integration, UI, migration, smoke, or manual checks that prove the behavior.
- Acceptance criteria: make "done" observable with concrete outcomes.
- Assumptions and out-of-scope: record unresolved facts, chosen defaults, and boundaries.

## Quality Bar

- Use repository conventions over invented architecture.
- Keep plans executable, not encyclopedic. More detail is useful only when it prevents an implementation decision or likely mistake.
- Avoid broad refactors unless they are necessary for the requested outcome.
- Include exact commands only when they are known from the repo or can be confidently derived.
- For high-stakes domains such as security, legal, medical, financial, or production data, require stronger source verification and explicit failure handling.
- For frontend work, include responsive states, empty/loading/error states, interaction details, and visual verification when they affect acceptance.
- For documentation-only work, include the exact docs to create or update and the consistency checks to run.
