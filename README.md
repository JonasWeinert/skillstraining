# Lumora Agent Skills Training Demo

This repository is a synthetic World Bank-style coding-agent training project.
It teaches how reusable agent skills improve output on realistic development
research and operations tasks.

Participants who cannot use `git` can download
`lumora-agent-skills-training-demo.zip` from the repository root and unzip it
locally.

The mock study is the **Lumora Family Support Grant Evaluation**, a fictional
cash transfer program with baseline, follow-up, payment, field visit, survey
log, and back-check data.

## What Is Included

- Synthetic raw CSV data in `data/raw/`
- Participant-facing Stata pipeline in `code/stata/`
- Pre-generated Stata tables and figures for the manager deck exercise in `outputs/`
- A baseline deck for participants to update:
  - `decks/baseline_round1_deck.pptx`
- A source library of agent skills in `skills/`
- Exercise-specific skill setup instructions in `.agents/README.md`
- Role-specific exercises in `exercises/`

## Run The Stata Pipeline

Open Stata from the project root and run:

```stata
do "code/stata/MasterDoFile.do"
```

The Stata pipeline imports raw CSVs, writes intermediate `.dta` files, creates
the processed household panel, exports tables, figures, and QA notes.

Expected outputs include:

- `data/intermediate/*.dta`
- `data/processed/analysis_household_panel.csv`
- `outputs/tables/*.csv`
- `outputs/figures/targeting_funnel.png`
- `outputs/figures/payment_provider_delay.png`
- `outputs/figures/welfare_change.png`
- `outputs/figures/enumerator_quality_flags.png`
- `outputs/qa_reports/stata_pipeline.log`

## Participant Tasks

Each exercise uses the same before/after workflow:

1. clear `.agents/skills/` and run the task with a general coding agent;
2. evaluate the output against the exercise checklist;
3. copy in only the role-specific skills;
4. run the same substantive task again;
5. compare what changed and what still needs human judgment.

See `exercises/comparison_prompts.md` for the shared scorecard.

## Skill Setup

The source skills live in `skills/`. For the workshop, copy only the skills
needed for the current exercise into `.agents/skills/`.

See [.agents/README.md](.agents/README.md) for role-specific copy commands.

You can run a baseline prompt first, then activate the relevant skill set and compare the difference.

Managers:

- update `decks/baseline_round1_deck.pptx` with follow-up outputs;
- inspect the Stata do-files first;
- produce an update log mapping slide claims to generated outputs.

Field coordinators:

- run high-frequency data quality checks;
- produce an actionable follow-up list before the next payment cycle.

Research assistants:

- clean and construct the household panel;
- validate IDs and merges;
- generate tables and figures reproducibly.

## Important Caveat

All data are synthetic. Welfare changes are descriptive monitoring evidence,
not causal estimates of program impact.
