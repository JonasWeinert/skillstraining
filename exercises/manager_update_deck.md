# Manager Exercise: Update The Round 1 Deck

## Scenario

The team prepared `decks/baseline_round1_deck.pptx` after round 1. Follow-up
data, figures, and tables now exist. Use a coding agent to update the deck
programmatically.

## Use These Skills

Copy these skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/wb-do-file-reader .agents/skills/
cp -R skills/wb-powerpoint-updater .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Prompt

```text
Use the local project skills. Inspect code/stata/MasterDoFile.do and the
downstream do-files first. Then inspect decks/baseline_round1_deck.pptx,
outputs/tables, and outputs/figures. Update the baseline deck with follow-up
evidence and write an update log that maps each changed slide to the table or
figure supporting it. Do not hand-type numbers that already exist in generated
outputs.
```

## Expected Outputs

- an updated PPTX deck;
- `outputs/qa_reports/deck_update_log.md`;
- a short list of remaining human-review questions.

## Evaluation Questions

- Did the agent inspect the analysis pipeline before editing slides?
- Did it preserve valid baseline context?
- Did it avoid causal language for descriptive welfare changes?
- Are slide numbers traceable to generated outputs?
