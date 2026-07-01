# Before/After Skill Comparison Workflow

Use this workflow for every exercise.

## 1. Start Without Skills

Clear project-local skills:

```bash
rm -rf .agents/skills/*
```

Give the agent the short no-skill prompt from the exercise file. Do not mention
the skill names. Let the agent solve the task with only the repository files and
its general knowledge.

## 2. Evaluate Against Expected Conditions

Use the checklist in the exercise file. For each condition, mark:

- `met`
- `partly met`
- `not met`

Pay special attention to whether the agent:

- inspected files before acting;
- traced numbers to generated outputs;
- validated IDs and merges;
- avoided causal claims from descriptive data;
- produced outputs a World Bank team could review or use.

## 3. Activate Skills

Copy only the role-specific skills into `.agents/skills/`. Do not copy every
skill for every task. The point is to see whether a focused skill set changes
the agent's behavior.

## 4. Re-Run With Skills

Use the skill-enabled prompt from the exercise file. The task should be the same
substantive task, but with instructions to use local project skills.

## 5. Compare Outputs

Discuss:

- What improved?
- What did not improve?
- Which skill instruction seems to have changed the agent behavior?
- Which expected condition is still unmet?
- What human judgment is still required?

## Optional Shared Scorecard

| Condition | No skills | With skills | Notes |
|---|---|---|---|
| Inspected source files first |  |  |  |
| Used generated outputs, not hand-typed numbers |  |  |  |
| Logged assumptions and caveats |  |  |  |
| Produced role-appropriate output |  |  |  |
| Avoided unsupported causal claims |  |  |  |

