---
name: wb-do-file-reader
description: >
  World Bank-style Stata do-file and analysis-script reader. Use when
  inspecting `.do`, Python, or R scripts to understand generated tables,
  figures, samples, indicator definitions, merge logic, hardcoded numbers, and
  the provenance of claims before updating a deck or briefing.
workflow_stage: code-review
version: 1.0.0
tags: [stata, do-files, provenance, reproducibility, slide-updates]
---

# WB Do-file Reader

Use this skill before editing presentations or summaries derived from analysis code.

## Inspection Workflow

1. Identify the master script and execution order.
2. List raw inputs, intermediate files, processed outputs, tables, figures, and logs.
3. Extract the unit of analysis for each script.
4. Trace indicator definitions and sample restrictions.
5. Find ID checks, duplicate handling, merge cardinality checks, and unresolved warnings.
6. Flag hardcoded numbers in prose, slides, or scripts.
7. Summarize which outputs support each deck claim.

## Red Flags

- `merge m:m` in Stata or many-to-many joins without aggregation;
- `drop if` without logged counts;
- `use` or `save, replace` touching raw data;
- manual edits to generated tables;
- before/after welfare language presented as causal impact;
- slide numbers that do not match generated tables.

Use:

- [references/script-review-template.md](references/script-review-template.md) for the review structure.
- [examples/provenance-note.md](examples/provenance-note.md) as a reporting example.

