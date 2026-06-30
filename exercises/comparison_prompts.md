# Before/After Skill Comparison Prompts

## Weak Baseline Prompt

```text
Analyze the Lumora cash transfer data and update the presentation with the new
follow-up findings.
```

Likely weaknesses:

- jumps into editing the deck;
- misses data quality checks;
- hand-types numbers;
- overstates welfare changes;
- does not trace outputs to scripts.

## Skilled Prompt

```text
Use the local skills in skills/agent-policy, skills/wb-do-file-reader,
skills/wb-powerpoint-updater, skills/reproducible-development-data-analysis,
and skills/development-data-caution. Inspect the Stata pipeline, generated
tables, generated figures, and baseline PowerPoint before editing. Update the
deck and write an update log mapping every revised slide claim to its source.
```

For a realistic comparison, copy the relevant skills into `.agents/skills/`
only after running the weak baseline prompt.

Expected improvements:

- inspects before acting;
- validates output provenance;
- preserves valid baseline material;
- uses generated outputs rather than manually typed numbers;
- adds appropriate caveats and human-review questions.
