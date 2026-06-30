---
name: reproducible-development-data-analysis
description: >
  Reproducible development microdata analysis skill for Stata. Use when
  cleaning Lumora household, follow-up, payment, survey log, field visit, or
  back-check data; building processed datasets; validating IDs and merges;
  creating Stata tables/figures; or adapting World Bank/DIME-style analysis
  scripts.
workflow_stage: data-analysis
version: 1.0.0
tags: [stata, reproducibility, dime, microdata, merge-validation]
---

# Reproducible Development Data Analysis

Start with `agent-policy`.

## Workflow

1. Inspect the raw files, codebook, and existing scripts before editing.
2. State the unit of observation for every dataset.
3. Assert identifiers:
   - household data: `hhid`;
   - payments: `hhid payment_cycle`;
   - logs: `submission_id`;
   - back-checks: `backcheck_id`;
   - field visits: `visit_id`.
4. Treat `data/raw/` as immutable.
5. Write intermediate Stata datasets to `data/intermediate/` and analysis-ready outputs to `data/processed/`.
6. Validate every merge with explicit cardinality and inspect non-matches.
7. Log every filter, duplicate resolution, and derived variable.
8. Export tables and figures from Stata code; do not copy numbers by hand.

## Indicator Definitions

Use these project definitions unless the human changes them:

- `coverage_eligible`: eligible baseline household with any admin payment.
- `exclusion_eligible`: eligible baseline household with no admin payment.
- `leakage_ineligible`: ineligible baseline household with any admin payment.
- `payment_delay_days`: actual payment date minus scheduled date.
- `underpaid_cycle`: expected transfer is positive, payment did not fail, and amount paid is below expected.
- `followup_observed`: household appears in follow-up survey.
- `flag_any_quality_issue`: any ID, range, survey-log, payment mismatch, back-check, or unresolved field-visit flag.

## Decision Policy

ASK before changing eligibility, dropping duplicates, redefining coverage, or making causal claims.

DEFAULT + flag:

- use the first baseline record per duplicate `hhid` only for the training demo;
- keep admin/self-report mismatches as review flags, not corrections;
- use descriptive changes for welfare outcomes.

DOCUMENT:

- duplicate counts;
- missing PMT concentration;
- merge match counts;
- attrition and follow-up response;
- payment failure and delay calculations.

Use:

- [references/lumora-indicators.md](references/lumora-indicators.md) for definitions and expected outputs.
- [examples/stata-analysis-prompt.md](examples/stata-analysis-prompt.md) for a participant-ready task.

