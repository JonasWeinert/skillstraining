# World Bank Agent Skills Demo Project Plan

## Purpose

Create a self-contained mock project that teaches World Bank staff how project-specific agent skills improve coding-agent output on realistic development research tasks.

The project should not be a generic prompt-engineering demo. It should show that skills help agents:

- inspect data and code before acting;
- respect reproducible research conventions;
- understand World Bank/DIME-style data work;
- produce role-appropriate outputs for managers, field coordinators, and research assistants;
- update real project artifacts programmatically rather than drafting disconnected prose.

## Inspected Inputs

This plan is based on direct inspection of:

- `Lecture Slides - Data quality assurance.pdf`, 40 slides, in this repository.
- `https://github.com/JonasWeinert/EconAgentSkills/tree/main`, especially:
  - `README.md`
  - `_skills/AGENT_POLICY.md`
  - `_skills/data/working-with-data/SKILL.md`
  - `_skills/data/stata-data-cleaning/SKILL.md`
  - `_skills/communication/econ-visualization/SKILL.md`
  - `_skills/communication/beamer-presentation/SKILL.md`

Relevant takeaways from the data-quality deck:

- Data quality protocols should define what checks are run, who runs them, how often, where results are shared, and how results are communicated to data providers.
- Checks should cover completeness, distribution, consistency, and survey-specific issues.
- Teams should first verify unique, non-missing IDs, then completeness across time, space, and units.
- Distribution checks should identify implausible ranges, outliers, and unexpected missingness.
- Consistency checks should compare values across variables, across time, and against external/contextual expectations.
- Survey-specific checks should examine enumerator effects, survey duration, refusals, "don't know" responses, loop-triggering questions, and accumulated quality flags.
- High-frequency checks should start early and run daily or as soon as data is received.
- Field validation includes back-checks, spot-checks, and audio audits, with results processed quickly enough to be actionable.
- HFC outputs should be shareable, reproducible, customizable, and understandable by staff with limited coding background.

Relevant takeaways from EconAgentSkills:

- Use a four-level human-in-the-loop policy: ASK, DEFAULT + flag, DOCUMENT, PROCEED.
- Raw data is immutable.
- Numbers should come from code, not hand-typed into documents.
- Every dropped observation should have a reason and before/after counts.
- Identifiers and merge cardinality should be asserted.
- Scripts should include a decisions log documenting assumptions and inferred choices.
- DIME-style guidance is especially relevant for data folder structure, master do-files, codebook-driven cleaning, duplicate checks, PII discipline, graph review, and reproducible output export.

## Synthetic Study Context

The mock project will be a fictional World Bank-supported social protection operation.

Project name:

**Lumora Family Support Grant Evaluation**

Country:

**Republic of Lumora**

Program:

**Family Support Grant**, a cash transfer program targeting poor and vulnerable households.

Study context:

The team completed baseline/round 1 analysis and prepared a PowerPoint deck for an internal review. Follow-up data has now arrived. The coding agent must help different staff update analysis products and operational follow-up materials using project skills.

Core questions:

- Is the program reaching intended households?
- Are payments reliable across regions and providers?
- Are there early welfare changes between baseline and follow-up?
- Which data quality issues need field follow-up before the next payment cycle?
- How should the baseline presentation be updated with new follow-up evidence?

## Project Deliverables

The repository should contain:

- synthetic raw data;
- scripts that generate the data;
- working analysis scripts;
- baseline and follow-up figures/tables;
- an existing baseline PowerPoint deck;
- a script that updates the PowerPoint deck with follow-up figures and insights;
- role-specific skills under `skills/`;
- short exercise prompts showing before/after use of skills.

Proposed structure:

```text
skillstraining/
  README.md
  DEMO_PROJECT_PLAN.md
  data/
    raw/
      households_baseline.csv
      households_followup.csv
      payments.csv
      field_visits.csv
      survey_logs.csv
      backchecks.csv
      codebook.csv
    processed/
      analysis_household_panel.csv
      payment_reliability_summary.csv
      data_quality_flags.csv
  scripts/
    00_generate_synthetic_data.py
    01_clean_and_construct.py
    02_make_tables.py
    03_make_figures.py
    04_update_powerpoint.py
    utils/
      project_paths.py
      qa_checks.py
      pptx_helpers.py
  outputs/
    tables/
    figures/
    memos/
    qa_reports/
  decks/
    baseline_round1_deck.pptx
    wb_style_reference.md
  skills/
    agent-policy/
      SKILL.md
    wb-do-file-reader/
      SKILL.md
    wb-powerpoint-updater/
      SKILL.md
    field-data-quality-hfc/
      SKILL.md
    reproducible-development-data-analysis/
      SKILL.md
    development-data-caution/
      SKILL.md
  exercises/
    manager_update_deck.md
    field_coordinator_hfc_review.md
    research_assistant_analysis.md
    comparison_prompts.md
```

## Data Design

The synthetic data should be fake but plausible enough to support realistic workflow mistakes.

### `households_baseline.csv`

Unit: household.

Candidate fields:

- `hhid`
- `region`
- `district`
- `village`
- `urban`
- `hh_size`
- `female_head`
- `disability_member`
- `children_under5`
- `school_age_children`
- `proxy_means_score`
- `eligible_baseline`
- `food_insecurity_score_bl`
- `school_attendance_rate_bl`
- `health_visit_last_month_bl`
- `survey_date_bl`
- `enum_id_bl`

Intentional issues:

- a small number of duplicate `hhid` values;
- one district with unexpectedly low completion;
- implausible household sizes;
- missing proxy means scores concentrated under one enumerator.

### `households_followup.csv`

Unit: household follow-up survey.

Candidate fields:

- `hhid`
- `survey_date_fu`
- `enum_id_fu`
- `food_insecurity_score_fu`
- `school_attendance_rate_fu`
- `health_visit_last_month_fu`
- `received_transfer_self_report`
- `grievance_awareness`
- `satisfaction_score`
- `attrition_reason`

Intentional issues:

- attrition concentrated in one district;
- inconsistent self-reported receipt versus payment records;
- suspiciously short survey durations for selected enumerators;
- more "don't know" responses for one module.

### `payments.csv`

Unit: household-payment cycle.

Candidate fields:

- `hhid`
- `payment_cycle`
- `scheduled_date`
- `actual_date`
- `provider`
- `transfer_amount_expected`
- `transfer_amount_paid`
- `failed_payment`
- `failure_reason`

Intentional issues:

- delayed payments concentrated by provider and district;
- underpayments in one payment cycle;
- failed payments due to missing IDs or inactive accounts;
- a few payments for households not marked eligible.

### `field_visits.csv`

Unit: field visit or grievance follow-up.

Candidate fields:

- `visit_id`
- `hhid`
- `visit_date`
- `field_officer_id`
- `district`
- `issue_category`
- `issue_severity`
- `resolved`
- `notes`

Intentional issues:

- open severe cases;
- repeated visits for the same household;
- mismatch between visit district and household district;
- qualitative notes that point to likely operational follow-up categories.

### `survey_logs.csv`

Unit: submitted survey.

Candidate fields:

- `submission_id`
- `hhid`
- `round`
- `enum_id`
- `start_time`
- `end_time`
- `duration_minutes`
- `consent`
- `refusal`
- `gps_accuracy`
- `module_missing_count`
- `dont_know_count`

This supports field-coordinator exercises based directly on the DQA deck's HFC guidance.

### `backchecks.csv`

Unit: back-check survey.

Candidate fields:

- `backcheck_id`
- `hhid`
- `backchecker_id`
- `backcheck_date`
- `respondent_confirmed`
- `hh_size_bc`
- `received_transfer_bc`
- `key_discrepancy_count`
- `requires_followup`

This supports spot-check/back-check exercises.

## Script Design

### `00_generate_synthetic_data.py`

Purpose:

- Generate all raw CSVs from a fixed random seed.
- Encode intentional problems in transparent sections.
- Write a short data-generation note to `outputs/qa_reports/synthetic_data_design.md`.

Acceptance criteria:

- Re-running the script reproduces the same files.
- Intentional issues are documented but not solved.
- Raw data is only written by this script.

### `01_clean_and_construct.py`

Purpose:

- Validate IDs.
- Inspect duplicates, missingness, ranges, and merge cardinality.
- Construct a household panel.
- Create derived indicators.

Core indicators:

- eligibility rate;
- coverage among eligible households;
- leakage to ineligible households;
- exclusion among eligible households;
- payment delay in days;
- failed payment rate;
- underpayment rate;
- attrition rate;
- change in food insecurity score;
- change in school attendance;
- discrepancy flags between survey and payments.

Acceptance criteria:

- Script starts with a decisions log.
- Every filter logs before/after counts.
- Every merge uses explicit cardinality validation.
- It writes clean outputs to `data/processed/`.
- It does not overwrite raw data.

### `02_make_tables.py`

Purpose:

- Produce machine-readable and presentation-ready tables.

Tables:

- baseline sample profile;
- follow-up response and attrition summary;
- targeting indicators;
- payment reliability by provider and district;
- welfare indicators from baseline to follow-up;
- data-quality issue counts by enumerator/district.

Acceptance criteria:

- Tables are produced from processed data only.
- Outputs are saved as CSV and Markdown.
- Numbers are not hand-entered into prose or slides.

### `03_make_figures.py`

Purpose:

- Produce figures used in the deck and exercises.

Figures:

- targeting funnel;
- payment delay by provider;
- payment reliability map-like district chart;
- baseline-to-follow-up welfare changes;
- enumerator quality flags;
- field follow-up priority matrix.

Acceptance criteria:

- Figures are saved to `outputs/figures/`.
- Figures are sized for slides.
- Colors are restrained and colorblind-safe.
- Each figure has a clear title, unit, and source note where appropriate.

### `04_update_powerpoint.py`

Purpose:

- Programmatically update the baseline deck with follow-up figures, tables, and revised insights.

Inputs:

- `decks/baseline_round1_deck.pptx`
- `outputs/tables/`
- `outputs/figures/`
- generated tables and Stata figures in `outputs/tables/` and `outputs/figures/`.

Outputs:

- `outputs/qa_reports/deck_update_log.md`

Acceptance criteria:

- Existing baseline slides are preserved where still valid.
- Outdated baseline-only claims are replaced or marked as baseline-only.
- Follow-up slides use the new figures and tables.
- Speaker notes or an update log identify what changed.
- World Bank-style branding rules are applied consistently.
- The script validates that every referenced figure/table exists before editing the deck.

## Skills To Build

### 1. `agent-policy`

Purpose:

Project-wide human-in-the-loop discipline adapted from EconAgentSkills.

Core behavior:

- ASK when the agent would make a substantive research or operational decision.
- DEFAULT + flag for conventional choices.
- DOCUMENT assumptions in decisions logs.
- PROCEED on standard reproducibility and validation steps.

This skill should be short and referenced by all other skills.

### 2. `reproducible-development-data-analysis`

Primary audience:

Research assistants and analysts.

Purpose:

Help a coding agent clean, validate, merge, analyze, and export development microdata in a reproducible way.

Should teach the agent to:

- inspect raw data before cleaning;
- state the unit of observation;
- assert unique IDs;
- validate merge cardinality;
- keep raw data immutable;
- log all filters and dropped observations;
- construct derived variables transparently;
- distinguish descriptive analysis from causal claims;
- save tables and figures from code.

This skill should borrow the discipline of EconAgentSkills' `working-with-data` and `stata-data-cleaning`, but use the mock project's Python scripts unless we later decide to include Stata.

### 3. `field-data-quality-hfc`

Primary audience:

Field coordinators and operations staff.

Purpose:

Help a coding agent produce high-frequency data quality checks and operational follow-up outputs.

This skill should be explicitly oriented around `Lecture Slides - Data quality assurance.pdf`.

Should teach the agent to check:

- completeness against expected units, time, and geography;
- duplicate and missing IDs;
- range and distribution anomalies;
- internal consistency across variables;
- consistency across baseline, follow-up, payments, logs, and back-checks;
- enumerator effects;
- survey duration anomalies;
- refusal and consent patterns;
- "don't know" and module-missing patterns;
- progress by village/district;
- back-check discrepancies;
- severe unresolved field issues.

Should produce:

- a field follow-up list;
- an HFC summary table;
- enumerator/district/provider issue ranking;
- concise recommendations for field action.

Important stance:

- Avoid accusatory language.
- Distinguish data-entry errors, implementation bottlenecks, and potential protocol concerns.
- Prioritize issues that are actionable before the next payment cycle.

### 4. `wb-do-file-reader`

Primary audience:

Managers and technical leads who need to understand what analysis scripts actually did.

Purpose:

Help a coding agent inspect Stata `.do` files or Python analysis scripts and summarize the analysis pipeline accurately before updating a deck.

Should teach the agent to:

- identify inputs and outputs;
- trace which scripts generate which tables/figures;
- extract variable definitions and indicator logic;
- find sample restrictions;
- identify whether claims are baseline-only or use follow-up data;
- flag hardcoded numbers;
- flag fragile paths or non-reproducible steps;
- summarize analysis choices in manager-readable language.

Even if the MVP uses Python, include this skill because World Bank staff will often encounter Stata do-files.

### 5. `wb-powerpoint-updater`

Primary audience:

Managers, TTLs, program leads, and technical leads.

Purpose:

Help a coding agent update an existing PowerPoint deck programmatically using new figures, tables, and insights.

Should teach the agent to:

- inspect the existing deck structure before editing;
- identify stale baseline-only claims;
- map new outputs to the right slides;
- preserve slide intent and narrative order;
- update chart images and key takeaway text;
- create an update log;
- avoid hand-typing numbers that should come from generated tables;
- apply World Bank-like visual conventions.

Branding guidance for the mock project:

- Use a restrained institutional palette with World Bank blue as the main accent.
- Use clean sans-serif typography.
- Prefer white backgrounds, clear section headers, and uncluttered layouts.
- Use charts and tables as evidence, not decorative elements.
- Keep one main claim per slide.
- Avoid overwriting logos or attribution blocks unless the script explicitly handles them.

Implementation note:

- Do not use real restricted World Bank brand assets unless they are already available and licensed for this training context.
- The mock deck can use a text-only "World Bank Training Demo" footer or simple placeholder mark.

### 6. `development-data-caution`

Primary audience:

All participants.

Purpose:

Keep outputs appropriate for development research and operational settings.

Should teach the agent to:

- avoid causal claims from descriptive before/after data;
- avoid stigmatizing language about households, enumerators, providers, or local counterparts;
- state data limitations;
- distinguish household welfare, program targeting, payment delivery, and data quality;
- surface assumptions for human review;
- treat vulnerable populations and sensitive operational findings carefully.

## Role-Specific Exercises

### Manager Exercise: Update the Round 1 Deck

Scenario:

You have a PowerPoint deck prepared after baseline/round 1. Follow-up figures and tables have now been generated. Use the coding agent to inspect the analysis scripts, understand how indicators were produced, and update the deck programmatically.

Files used:

- `decks/baseline_round1_deck.pptx`
- `scripts/01_clean_and_construct.py`
- `scripts/02_make_tables.py`
- `scripts/03_make_figures.py`
- `outputs/tables/`
- `outputs/figures/`
- skills:
  - `wb-do-file-reader`
  - `wb-powerpoint-updater`
  - `development-data-caution`

Expected output:

- `outputs/qa_reports/deck_update_log.md`

Teaching point:

The skill should make the agent inspect the analysis pipeline and deck before editing. The visible improvement should be fewer unsupported claims, fewer stale baseline statements, and a deck that is actually linked to generated outputs.

### Field Coordinator Exercise: High-Frequency Data Quality Review

Scenario:

Follow-up survey, payment, field visit, and back-check data have arrived. Identify data quality and operational follow-up priorities before the next payment cycle.

Files used:

- `data/raw/households_followup.csv`
- `data/raw/payments.csv`
- `data/raw/survey_logs.csv`
- `data/raw/backchecks.csv`
- `data/raw/field_visits.csv`
- skill:
  - `field-data-quality-hfc`
  - `development-data-caution`

Expected output:

- `outputs/qa_reports/hfc_summary.md`
- `outputs/tables/field_followup_list.csv`
- `outputs/figures/enumerator_quality_flags.png`
- `outputs/figures/payment_provider_delay.png`

Teaching point:

The skill should make the agent produce actionable follow-up outputs, not just descriptive statistics. It should follow the deck's DQA logic: completeness, distribution, consistency, survey-specific checks, and field validation.

### Research Assistant Exercise: Reproducible Follow-Up Analysis

Scenario:

Use baseline, follow-up, and payment data to produce clean analysis outputs and updated indicators.

Files used:

- `data/raw/households_baseline.csv`
- `data/raw/households_followup.csv`
- `data/raw/payments.csv`
- `data/raw/codebook.csv`
- scripts:
  - `01_clean_and_construct.py`
  - `02_make_tables.py`
  - `03_make_figures.py`
- skills:
  - `reproducible-development-data-analysis`
  - `development-data-caution`

Expected output:

- `data/processed/analysis_household_panel.csv`
- `outputs/tables/targeting_summary.csv`
- `outputs/tables/payment_reliability_summary.csv`
- `outputs/figures/targeting_funnel.png`
- `outputs/figures/welfare_change.png`

Teaching point:

The skill should make the agent define the unit of analysis, validate IDs, check merges, document assumptions, and avoid unsupported causal conclusions.

## Baseline vs Skilled-Agent Demonstration

The project should include comparison prompts that can be run with and without skills.

Example baseline prompt:

```text
Analyze the Lumora cash transfer data and update the presentation with the new follow-up findings.
```

Expected weak behavior:

- jumps into editing;
- misses data quality issues;
- hand-types numbers into slide text;
- treats before/after differences as causal;
- ignores how scripts generated outputs;
- produces generic recommendations.

Example skilled prompt:

```text
Use the wb-do-file-reader, reproducible-development-data-analysis,
wb-powerpoint-updater, and development-data-caution skills. Inspect the
scripts and outputs first, then update the round 1 deck with follow-up
figures and revised insights. Produce an update log showing which claims
changed and which outputs support each slide.
```

Expected improved behavior:

- inspects the deck and scripts first;
- traces table/figure provenance;
- updates stale claims;
- preserves valid baseline material;
- uses generated outputs rather than hand-entered values;
- documents assumptions and remaining review questions.

## Implementation Phases

### Phase 1: Project Skeleton and Synthetic Data

- Create directories.
- Write synthetic data generator.
- Generate raw CSVs.
- Inspect generated raw data manually.
- Add data-generation documentation.

Done when:

- all raw files exist;
- intentional issues are present and documented;
- generator is reproducible.

### Phase 2: Analysis Pipeline

- Write cleaning/construct script.
- Write table script.
- Write figure script.
- Run scripts end-to-end.
- Inspect outputs manually.

Done when:

- processed data exists;
- tables and figures exist;
- logs show data checks and assumptions;
- no raw files are overwritten.

### Phase 3: Baseline Deck and Programmatic Update

- Create a baseline PowerPoint deck with baseline-only insights.
- Generate follow-up insights from analysis outputs.
- Write PowerPoint update script.
- Produce updated deck and update log.
- Inspect the deck visually.

Done when:

- baseline and updated decks both exist;
- update script is reproducible;
- updated deck uses follow-up outputs;
- update log maps slides to source outputs.

### Phase 4: Skills

- Write six `SKILL.md` files.
- Keep each skill compact but operational.
- Include decision policies.
- Include file conventions and expected outputs.
- Include role-specific examples.

Done when:

- each exercise has the skills it needs;
- each skill points the agent toward inspection before action;
- skills are specific enough to change agent behavior.

### Phase 5: Exercises and README

- Write role-specific exercise files.
- Write comparison prompts.
- Write README with how to run the demo.
- Include expected outcomes and discussion points.

Done when:

- a participant can run the mock project locally;
- each role has a concrete task;
- before/after skill value is visible.

## Open Decisions

1. Should the MVP use only Python, or include Stata-style `.do` files as mock inputs for the manager exercise?

   Recommendation: Use Python for runnable scripts, but include at least one realistic `.do` file as a reading target for the `wb-do-file-reader` skill. This reflects World Bank workflows without making Stata a hard dependency.

2. Should the PowerPoint deck use a minimal mock World Bank style or attempt closer brand fidelity?

   Recommendation: Use a minimal mock institutional style unless official brand assets are available for this training context.

3. Should the field coordinator exercise output an HTML/PDF HFC dashboard?

   Recommendation: Start with Markdown, CSV, and figures. Add an HTML dashboard later if the first version is too static.

4. Should skills be written for Codex only or agent-agnostic `SKILL.md`?

   Recommendation: Write agent-agnostic `SKILL.md` files following the same pattern as EconAgentSkills.

## Definition of Done

The demo project is complete when:

- the raw synthetic data can be regenerated;
- analysis scripts run from scratch;
- tables and figures are produced by code;
- baseline and updated decks exist;
- the deck update is programmatic and logged;
- role-specific skills exist and are usable;
- exercises demonstrate clear before/after differences;
- all outputs have been inspected, not merely generated.
