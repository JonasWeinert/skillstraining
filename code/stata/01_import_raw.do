/* Import immutable raw CSV files to intermediate Stata datasets. */

version 17.0

local files households_baseline households_followup payments field_visits survey_logs backchecks codebook

foreach f of local files {
    import delimited using "${RAW}/`f'.csv", clear varnames(1) stringcols(_all)
    compress
    save "${INT}/`f'_raw.dta", replace
    di as result "Imported `f': " _N " rows"
}

