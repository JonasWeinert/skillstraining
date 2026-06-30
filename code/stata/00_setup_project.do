/* Create output directories expected by the Stata pipeline. */

version 17.0

foreach d in "${INT}" "${PROC}" "${OUT}" "${TABLES}" "${FIGS}" "${QA}" "${MEMOS}" {
    capture mkdir "`d'"
}

capture log close _all
log using "${QA}/stata_pipeline.log", text replace

di as text "Project root: ${ROOT}"
di as text "Raw data dir: ${RAW}"

