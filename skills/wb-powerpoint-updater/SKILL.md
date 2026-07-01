---
name: wb-powerpoint-updater
description: >
  Programmatic PowerPoint update skill for World Bank-style project decks. Use
  when updating an existing baseline PPTX with new generated Stata figures,
  tables, output provenance, slide-source mapping, restrained institutional
  styling, and an update log.
workflow_stage: communication
version: 1.0.0
tags: [powerpoint, deck-update, world-bank, provenance, stata-figures]
---

# WB PowerPoint Updater

Use `wb-do-file-reader` first when the deck depends on analysis scripts.

## Workflow

1. Inspect the existing deck before editing.
2. Identify baseline-only claims that need follow-up revision.
3. Inspect generated tables and Stata figures before inserting anything.
4. Map each updated slide to its source output.
5. Preserve valid baseline context; replace stale or unsupported claims.
6. Insert figures/tables from generated output paths.
7. Add or update caveats where evidence is descriptive.
8. Write `outputs/qa_reports/deck_update_log.md`.

## Mock Brand Guidance

- Use a white background with a restrained World Bank-blue accent.
- Use clear slide headlines that state claims.
- Keep one main claim per slide.
- Avoid decorative clutter.
- Keep tables short; prefer figures for slide evidence.
- Do not use restricted World Bank brand assets unless explicitly supplied.

## Quality Checks

Before finalizing:

- render or inspect the deck;
- check title wrapping, footer consistency, and figure readability;
- verify every number on updated slides is traceable to an output file;
- verify `outputs/qa_reports/deck_update_log.md` maps every changed slide to its source table or figure;
- ensure descriptive welfare results are not framed causally.

Use:

- [references/update-log-template.md](references/update-log-template.md) for the required log.
- [examples/deck-update-prompt.md](examples/deck-update-prompt.md) for a realistic participant prompt.
