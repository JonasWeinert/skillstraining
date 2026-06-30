# Research Assistant Exercise: Reproducible Follow-Up Analysis

## Scenario

Use baseline, follow-up, and payment data to create a clean household panel and
updated indicators.

## Use These Skills

Copy these skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/reproducible-development-data-analysis .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Prompt

```text
Use the local reproducible-development-data-analysis and development-data-caution
skills. Inspect the raw data and codebook, then run or adapt the Stata pipeline
under code/stata. Validate IDs, check duplicates, document merge cardinality,
construct the household panel, and regenerate the core tables and figures.
```

## Expected Outputs

- `data/processed/analysis_household_panel.csv`;
- `outputs/tables/targeting_summary.csv`;
- `outputs/tables/payment_reliability_summary.csv`;
- `outputs/tables/welfare_change_summary.csv`;
- figures in `outputs/figures/`;
- QA notes in `outputs/qa_reports/`.

## Evaluation Questions

- Did the agent define the unit of analysis?
- Did it inspect duplicates and missingness before cleaning?
- Did it validate merges?
- Did it avoid unsupported causal claims?
