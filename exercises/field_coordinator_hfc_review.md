# Field Coordinator Exercise: High-Frequency Data Quality Review

## Scenario

Follow-up survey data, payment data, back-checks, survey logs, and field visits
have arrived. Identify priority follow-up before the next payment cycle.

## Use These Skills

Copy these skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/field-data-quality-hfc .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Prompt

```text
Use the local field-data-quality-hfc and development-data-caution skills.
Review data/raw/households_followup.csv, data/raw/payments.csv,
data/raw/survey_logs.csv, data/raw/backchecks.csv, and
data/raw/field_visits.csv. Produce a high-frequency check summary and a
field follow-up list. Separate data-entry issues, implementation bottlenecks,
and cases requiring human review.
```

## Expected Outputs

- `outputs/qa_reports/hfc_summary.md`;
- `outputs/tables/field_followup_list.csv`;
- ranked enumerator, district, or provider issue summaries.

## Evaluation Questions

- Did the agent check completeness, distribution, consistency, and survey-specific issues?
- Did it use neutral operational language?
- Did it produce actions that a field coordinator could actually use?
