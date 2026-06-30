# Lumora Indicator Reference

## Core Units

- Baseline/follow-up household data: `hhid`
- Payments: `hhid payment_cycle`
- Survey logs: `submission_id`
- Back-checks: `backcheck_id`
- Field visits: `visit_id`

## Indicators

- `coverage_eligible`: eligible baseline household with at least one administrative payment.
- `exclusion_eligible`: eligible baseline household with no administrative payment.
- `leakage_ineligible`: ineligible baseline household with at least one administrative payment.
- `payment_delay_days`: actual date minus scheduled date.
- `underpaid_cycle`: expected positive payment, no failure, and amount paid below expected.
- `followup_observed`: household appears in follow-up data.
- `flag_any_quality_issue`: composite review flag from ID, range, survey-log, payment, back-check, and field-visit checks.

## Expected Stata Outputs

- `data/intermediate/*.dta`
- `data/processed/analysis_household_panel.dta`
- `data/processed/analysis_household_panel.csv`
- `outputs/tables/*.csv`
- `outputs/figures/*.png`
- `outputs/qa_reports/stata_pipeline.log`

