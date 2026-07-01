# Field Coordinator Exercise: High-Frequency Data Quality Review

## Role And Situation

You are a field coordinator reviewing the Lumora follow-up round before the next
cash transfer payment cycle. Several data sources have arrived:

- `data/raw/households_followup.csv`
- `data/raw/payments.csv`
- `data/raw/survey_logs.csv`
- `data/raw/backchecks.csv`
- `data/raw/field_visits.csv`

Your task is to use a coding agent to identify data quality and operational
follow-up priorities. The output should be practical: what should supervisors,
payment-provider focal points, or field officers review next?

The data include intentional issues that resemble a real follow-up round:
possible duplicate identifiers, unusual survey durations, elevated "don't know"
patterns for one enumerator, payment delays, failed payments, and provider-level
underpayment concerns. Participants should expect the agent to separate issues
that need field verification from issues that can be resolved by checking logs
or provider records.

## Step 1: Try Without Skills

Make sure `.agents/skills/` is empty:

```bash
rm -rf .agents/skills/*
```

Then give the agent this prompt:

```text
Review the Lumora follow-up data in data/raw and tell me what field issues need
follow-up before the next payment cycle. Create a short summary and a follow-up
list.
```

## Step 2: Evaluate The No-Skill Output

Evaluate the agent output against these expected conditions:

- It checks completeness against expected households, time, geography, and enumerators.
- It checks duplicate or missing IDs.
- It checks distributions, outliers, missingness, and implausible values.
- It checks consistency across survey, payment, back-check, and field-visit files.
- It reviews survey-specific patterns such as duration, refusals, and "don't know" responses.
- It distinguishes data-entry issues from implementation bottlenecks.
- It uses neutral language and avoids accusing households, enumerators, or providers.
- It produces `outputs/qa_reports/hfc_summary.md`.
- It produces `outputs/tables/field_followup_list.csv`.
- It prioritizes issues that can be acted on before the next payment cycle.

Mark each condition as:

- `met`
- `partly met`
- `not met`

## Step 3: Activate Skills

Copy the field coordinator skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/field-data-quality-hfc .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Step 4: Try With Skills

Give the agent this prompt:

```text
Use the local field-data-quality-hfc and development-data-caution skills.
Review data/raw/households_followup.csv, data/raw/payments.csv,
data/raw/survey_logs.csv, data/raw/backchecks.csv, and
data/raw/field_visits.csv. Produce outputs/qa_reports/hfc_summary.md and
outputs/tables/field_followup_list.csv. Separate completeness, distribution,
consistency, survey-specific, and field-validation checks. Distinguish
data-entry issues, implementation bottlenecks, and cases requiring human
review.
```

## Step 5: Compare

Compare the no-skill and skill-enabled outputs:

- Which output gave field staff more actionable next steps?
- Which output better followed the data-quality dimensions from the lecture slides?
- Which output used safer language around enumerators, households, and providers?
- Which output made the best use of back-checks and field visits?
- What did the skill-enabled agent still miss?
