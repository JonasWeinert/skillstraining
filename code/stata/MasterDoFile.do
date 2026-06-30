/*==============================================================================
Project: Lumora Family Support Grant Evaluation
Purpose: Run the participant-facing Stata analysis pipeline
Author : Training demo

Run from a clean Stata session:
    do "code/stata/MasterDoFile.do"

DECISIONS LOG (review before adapting to real data)
Unit of analysis: household for master data; household-payment-cycle for payments
Raw data: immutable CSV files in data/raw
Analysis sample: first non-duplicate baseline record per hhid
Follow-up: descriptive before/after analysis only; no causal impact claim
PII: synthetic only; no PII included
==============================================================================*/

version 17.0
clear all
set more off
set seed 20260630

* Resolve project root from the current working directory. Run from project root.
global ROOT "/Users/jonas/Documents/GitHub/skillstraining"
capture confirm file "${ROOT}/code/stata/MasterDoFile.do"
if _rc {
    di as error "Run this file from the project root: do code/stata/MasterDoFile.do"
    exit 198
}
global RAW "${ROOT}/data/raw"
global INT "${ROOT}/data/intermediate"
global PROC "${ROOT}/data/processed"
global OUT "${ROOT}/outputs"
global TABLES "${OUT}/tables"
global FIGS "${OUT}/figures"
global QA "${OUT}/qa_reports"

do "${ROOT}/code/stata/00_setup_project.do"
do "${ROOT}/code/stata/01_import_raw.do"
do "${ROOT}/code/stata/02_clean_construct.do"
do "${ROOT}/code/stata/03_make_tables.do"
do "${ROOT}/code/stata/04_make_figures.do"
do "${ROOT}/code/stata/05_export_deck_inputs.do"

di as result "Lumora Stata pipeline complete."
