---
name: field-data-quality-hfc
description: >
  High-frequency field data quality skill for World Bank survey and operations
  workflows. Use when reviewing Lumora follow-up surveys, survey logs, payment
  records, back-checks, field visits, enumerator effects, completeness,
  distribution, consistency, or operational follow-up priorities.
workflow_stage: field-operations
version: 1.0.0
tags: [hfc, fieldwork, survey-quality, backchecks, payments]
---

# Field Data Quality HFC

Use this skill to produce actionable field follow-up outputs. It is based on the local `Lecture Slides - Data quality assurance.pdf`.

## Checks To Run

**Completeness**

- Verify unique, non-missing IDs.
- Compare follow-up responses against baseline households.
- Check coverage across district, village, time, and enumerator.

**Distribution**

- Flag implausible values and unexpected missingness.
- Review survey duration, GPS accuracy, module-missing counts, and high "don't know" counts.

**Consistency**

- Compare self-reported transfer receipt with payment records.
- Compare district fields across household, payment, and field visit files.
- Compare back-check responses with original survey values.

**Survey-specific**

- Rank enumerators by short duration, refusals, module missingness, and quality flags.
- Identify early signs of repeated misunderstanding before they become habits.

**Field validation**

- Use back-checks and field visits to prioritize cases.
- Treat unresolved high-severity visits as urgent.

## Output Requirements

Produce:

- `outputs/qa_reports/hfc_summary.md`;
- `outputs/tables/field_followup_list.csv`;
- ranked enumerator, district, or provider tables;
- concise field actions for the next payment cycle.

Use:

- [references/hfc-checklist.md](references/hfc-checklist.md) for the full DQA checklist.
- [examples/hfc-review-prompt.md](examples/hfc-review-prompt.md) for a realistic participant prompt.

