# Synthetic Data Design

Seed: `20260630`

Raw files:
- `backchecks.csv`
- `codebook.csv`
- `field_visits.csv`
- `households_baseline.csv`
- `households_followup.csv`
- `payments.csv`
- `survey_logs.csv`

Intentional issues:
- duplicate baseline household IDs;
- implausible household sizes;
- PMT missingness concentrated under one enumerator;
- follow-up attrition concentrated in Ila district;
- short survey duration and high don't-know counts for selected enumerators;
- payment delays concentrated by provider/district;
- back-check and field-visit discrepancies requiring follow-up.

Important caution: these data are synthetic and should only be used for training.
