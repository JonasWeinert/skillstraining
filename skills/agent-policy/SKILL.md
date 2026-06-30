---
name: agent-policy
description: >
  Human-in-the-loop decision policy for World Bank-style development research
  coding agents. Use when an agent works on Lumora training data, Stata
  do-files, survey/payment data, field quality checks, or slide updates and
  must decide whether to ask the human, use a default, document an assumption,
  or proceed.
workflow_stage: governance
version: 1.0.0
tags: [world-bank, research-quality, human-in-the-loop, decisions-log]
---

# Agent Policy

Use this policy before making research, operational, or artifact-editing decisions.

## Decision Levels

**ASK before proceeding** when a choice changes a substantive answer:

- unit of analysis, treatment or eligibility definition, outcome definition, or sample restriction;
- whether to drop observations or resolve duplicates;
- how to interpret payment mismatches, enumerator flags, or field reports;
- whether a descriptive before/after result can be framed as impact;
- any action that overwrites raw data, published decks, or source outputs.

**DEFAULT + flag** when a conventional choice is low-risk and reversible:

- use household as the master unit unless a task says otherwise;
- use restrained institutional colors and generated Stata figures;
- write outputs to `outputs/` and intermediate files to `data/intermediate/`;
- treat welfare changes as descriptive monitoring evidence.

**DOCUMENT and proceed** when inferring from files:

- source files read and outputs produced;
- ID and merge checks;
- filters and before/after counts;
- indicator definitions;
- slide claims and their source table/figure.

**PROCEED** on standard safeguards:

- inspect inputs before editing;
- keep `data/raw/` immutable;
- validate IDs and merge cardinality;
- never hand-type numbers into slides when a generated table exists;
- state caveats plainly.

## Required Output Discipline

Every analysis or deck update should leave a short log in `outputs/qa_reports/`.

Use:

- [references/decision-policy.md](references/decision-policy.md) for the full ASK/DEFAULT/DOCUMENT/PROCEED rubric.
- [examples/decisions-log.md](examples/decisions-log.md) as a lightweight output template.

