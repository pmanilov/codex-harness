# Ralph Patterns Reference

## Source-Grounded Meaning

Ralph is an agent-loop pattern, not a single product. The useful abstraction is: give an agent a goal, make one attempt, evaluate it with an external validator, feed the result back into the next attempt, and repeat until a valid result or a budget boundary.

The CMU CRDAL paper defines the plain Ralph Wiggum Loop (RWL) as a design agent repeatedly generating solutions until a valid final design is produced. After each generation, numerical evaluation and validation provide feedback; the agent receives the design history and feedback, reflects, and creates another design. The agent may continue improving even after a valid design, but can terminate only after receiving validator feedback that the design is valid and deciding no meaningful improvement remains. The paper used a 30-generation maximum in its experiment.

Geoffrey Huntley's practitioner framing emphasizes a monolithic loop: one repository, one process, one task per loop. The operator watches failures, improves the loop or task context, and uses the loop manually or with automation pauses rather than building complex multi-agent systems first.

FactorMiner instantiates Ralph as `retrieve -> generate -> evaluate -> distill`: retrieve memory priors, generate candidates, evaluate with deterministic checks, update the library, and distill experience back into memory for future iterations.

Sources:

- CMU CRDAL paper: https://arxiv.org/pdf/2603.24768
- Associated CRDAL codebase: https://github.com/cmudrc/Co_Regulation_Design_Agent_Loop_IDETC
- Geoffrey Huntley post: https://ghuntley.com/loop/
- FactorMiner paper: https://ar5iv.labs.arxiv.org/html/2602.14670

## Variants

Use Plain Ralph when the task has a clear validator and low risk:

```text
attempt -> validate -> feed back failures -> retry
```

Use SRL when progress is noisy or the agent may lose track:

```text
attempt -> validate -> summarize trajectory -> set next goal/strategy -> retry
```

Use CRDAL-lite by default for software work:

```text
attempt -> validate -> summarize trajectory -> reviewer strategy pass -> retry
```

Use memory/distillation when the loop spans sessions:

```text
retrieve lessons -> attempt -> validate -> distill lessons -> update reusable memory
```

## Loop Frame Template

```text
Goal:
Acceptance criteria:
Validator:
Safety scope:
Iteration budget:
Stop conditions:
```

## Ledger Template

```text
| Iter | Action | Validation | Progress | Review | Next |
| ---- | ------ | ---------- | -------- | ------ | ---- |
| 1 | <attempt> | <pass/fail + key output> | <improving/stalling/regressing> | <bottleneck + anti-fixation note> | <next smallest change> |
```

## Reviewer Pass Template

Use this structure for the CRDAL-lite review pass:

```text
Review the current loop state.

Goal: <goal>
Acceptance: <criteria>
History: <brief ledger>
Latest validation: <material output>

Return:
- Progress: improving, stalling, or regressing
- Bottleneck: the constraint currently blocking success
- Fixation risk: repeated assumption or approach to avoid
- Next strategy: the smallest concrete change for the next iteration
- Safety flag: approval needed or no issue
```

Do not ask the reviewer to solve the task from scratch. Ask for strategy, bottleneck detection, and risk flags.

## Validation Choices

Prefer validators in this order:

1. Existing targeted tests or checks directly covering the changed behavior.
2. Build/type/lint checks when unit coverage is absent.
3. A small reproducible smoke command.
4. Browser/UI screenshots or API probes for user-facing behavior.
5. Manual acceptance criteria explicitly provided by the user.

If no trustworthy validator exists, stop and report the validation gap instead of looping on model judgment.

## Budget And Failure Handling

Default budgets:

- Normal local coding task: 5 iterations.
- Risky task, broad refactor, migration, or production-adjacent work: 2 iterations.
- User-specified loop budget: use the user's value unless it conflicts with safety instructions.

Repeated failure policy:

- If the same validator fails for the same reason twice, the next reviewer pass must propose a different strategy.
- If the same blocker appears for 3 consecutive loop turns, stop and report the blocker.
- If validation is flaky, isolate flakiness before treating the loop as successful.

## Local-Only Guardrails

The default Ralph loop must not:

- deploy, publish, push, or change remote state;
- access secrets or production data;
- perform broad deletion, reset, or irreversible migration;
- weaken tests or acceptance criteria to make validation pass;
- fabricate reports, fixtures, or metrics to hide failures.

Escalate for explicit approval when the next useful action crosses these boundaries.
