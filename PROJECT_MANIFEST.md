# Project Manifest

## Core Participant Files

- `README.md`
- `demoporject_manage/DEMO_PROJECT_PLAN.md`
- `Lecture Slides - Data quality assurance.pdf`
- `code/stata/MasterDoFile.do`
- `decks/baseline_round1_deck.pptx`
- `skills/*/SKILL.md`
- `skills/*/references/*.md`
- `skills/*/examples/*.md`
- `.agents/README.md`
- `exercises/*.md`

## Synthetic Data

- `data/raw/households_baseline.csv`
- `data/raw/households_followup.csv`
- `data/raw/payments.csv`
- `data/raw/field_visits.csv`
- `data/raw/survey_logs.csv`
- `data/raw/backchecks.csv`
- `data/raw/codebook.csv`

## Shipped Exercise Inputs

- `outputs/tables/targeting_summary.csv`
- `outputs/tables/payment_reliability_summary.csv`
- `outputs/tables/welfare_change_summary.csv`
- `outputs/tables/enumerator_quality_summary.csv`
- `outputs/figures/targeting_funnel.png`
- `outputs/figures/payment_provider_delay.png`
- `outputs/figures/welfare_change.png`
- `outputs/figures/enumerator_quality_flags.png`
- `outputs/qa_reports/synthetic_data_design.md`

## Notes

The Stata pipeline is participant-facing and runnable on a machine with Stata
17 or newer. The Python materializer exists only to regenerate synthetic CSVs
and non-figure tabular artifacts for facilitators. Workshop participants can
start from the included `data/raw/*.csv` files and run Stata only.
