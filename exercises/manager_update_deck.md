# Manager Exercise: Update The Round 1 Deck

## Role And Situation

You are a task team lead preparing for a short internal review of the fictional
**Lumora Family Support Grant**. The team has a baseline deck from round 1:

- `decks/baseline_round1_deck.pptx`

Follow-up tables and Stata-generated figures are already available:

- `outputs/tables/targeting_summary.csv`
- `outputs/tables/payment_reliability_summary.csv`
- `outputs/tables/welfare_change_summary.csv`
- `outputs/figures/targeting_funnel.png`
- `outputs/figures/payment_provider_delay.png`
- `outputs/figures/welfare_change.png`
- `outputs/figures/enumerator_quality_flags.png`

Your task is to use a coding agent to update the baseline deck with follow-up
evidence. The agent should inspect the Stata pipeline before editing the deck.
The follow-up story is not a full impact evaluation. It combines operational
monitoring results: targeting coverage, payment reliability by provider, survey
quality flags, and descriptive changes in household welfare indicators. A good
deck update should make those distinctions visible to reviewers.

## Step 1: Try Without Skills

Make sure `.agents/skills/` is empty:

```bash
rm -rf .agents/skills/*
```

Then give the agent this prompt:

```text
Update decks/baseline_round1_deck.pptx with the new Lumora follow-up findings
using the tables and figures in outputs/. Create an updated deck and briefly
summarize what changed.
```

## Step 2: Evaluate The No-Skill Output

Evaluate the agent output against these expected conditions:

- It inspects `code/stata/MasterDoFile.do` and downstream do-files before editing.
- It identifies which baseline-only claims need revision.
- It uses generated Stata tables and figures, not hand-typed numbers.
- It preserves valid baseline context instead of rewriting the whole deck.
- It adds caveats for descriptive welfare changes.
- It creates `outputs/qa_reports/deck_update_log.md`.
- The update log maps each changed slide to a source table or figure.
- It leaves human-review questions where interpretation is uncertain.

Mark each condition as:

- `met`
- `partly met`
- `not met`

## Step 3: Activate Skills

Copy the manager skills into `.agents/skills/`:

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/wb-do-file-reader .agents/skills/
cp -R skills/wb-powerpoint-updater .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Step 4: Try With Skills

Give the agent this prompt:

```text
Use the local project skills. Inspect code/stata/MasterDoFile.do and the
downstream do-files first. Then inspect decks/baseline_round1_deck.pptx,
outputs/tables, and outputs/figures. Update the baseline deck with follow-up
evidence and write outputs/qa_reports/deck_update_log.md mapping each changed
slide to the table or figure supporting it. Do not hand-type numbers that
already exist in generated outputs. Use cautious language for descriptive
welfare changes.
```

## Step 5: Compare

Compare the no-skill and skill-enabled outputs:

- Which output better traced evidence to source files?
- Which output made fewer unsupported claims?
- Which output was easier for a manager to review quickly?
- Which output left clearer human-review questions?
- What did the skill-enabled agent still miss?
