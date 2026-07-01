# Research Assistant Exercise: Reproducible Follow-Up Analysis

## Role And Situation

You are a research assistant asked to reproduce the Lumora follow-up analysis.
The raw data are already in `data/raw/`, and the Stata pipeline is in
`code/stata/`.

Your task is to use a coding agent to inspect the raw data and Stata code, run
or adapt the pipeline, and produce reproducible analysis outputs. The agent
should not silently change definitions or make causal claims.

The mock study is designed to surface common RA decisions: resolving intentional
baseline duplicate IDs, checking merge cardinality across household, payment,
survey-log, back-check, and field-visit files, and preserving a clear distinction
between operational indicators and descriptive welfare changes.

## Step 1: Try Without Skills

Make sure `.agents/skills/` is empty:

```bash
rm -rf .agents/skills/*
```

Then give the agent this prompt:

```text
Run the Lumora analysis from the raw data. Clean the data, create the household
panel, and regenerate the tables and figures.
```

## Step 2: Evaluate The No-Skill Output

Evaluate the agent output against these expected conditions:

- It inspects `data/raw/` and `data/raw/codebook.csv` before writing or running code.
- It states the unit of observation for each raw file.
- It validates unique IDs and identifies duplicate baseline household IDs.
- It validates merge cardinality before merging datasets.
- It keeps `data/raw/` immutable.
- It logs filters, duplicate handling, and before/after counts.
- It creates `data/processed/analysis_household_panel.csv`.
- It creates targeting, payment reliability, welfare, and enumerator quality tables.
- It creates Stata-generated figures in `outputs/figures/`.
- It treats welfare changes as descriptive, not causal.
- It records assumptions or human-review questions.

Mark each condition as:

- `met`
- `partly met`
- `not met`

## Step 3: Activate Skills

Copy the research assistant skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/reproducible-development-data-analysis .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Step 4: Try With Skills

Give the agent this prompt:

```text
Use the local reproducible-development-data-analysis and development-data-caution
skills. Inspect the raw data and codebook, then run or adapt the Stata pipeline
under code/stata. Validate IDs, check duplicates, document merge cardinality,
construct the household panel, regenerate the core tables and Stata figures,
and summarize assumptions that need human review.
```

## Step 5: Compare

Compare the no-skill and skill-enabled outputs:

- Which output was more reproducible from a clean session?
- Which output better documented ID, merge, and sample decisions?
- Which output made fewer silent assumptions?
- Which output handled descriptive welfare changes more carefully?
- What did the skill-enabled agent still miss?
