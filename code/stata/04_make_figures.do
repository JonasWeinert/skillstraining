/* Generate slide-friendly figures from Stata. */

version 17.0

set scheme s2color

use "${PROC}/analysis_household_panel.dta", clear
quietly count if eligible_baseline == 1
local eligible = r(N)
quietly count if eligible_baseline == 1 & coverage_eligible == 1
local covered = r(N)
quietly count if eligible_baseline == 1 & exclusion_eligible == 1
local excluded = r(N)
quietly count if eligible_baseline == 0 & leakage_ineligible == 1
local leakage = r(N)

clear
set obs 4
gen metric_order = _n
gen str14 metric = ""
gen value = .
replace metric = "Eligible" in 1
replace value = `eligible' in 1
replace metric = "Covered" in 2
replace value = `covered' in 2
replace metric = "Excluded" in 3
replace value = `excluded' in 3
replace metric = "Leakage" in 4
replace value = `leakage' in 4
label define metric_order_lbl 1 "Eligible" 2 "Covered" 3 "Excluded" 4 "Leakage"
label values metric_order metric_order_lbl
graph bar value, over(metric_order, relabel(1 "Eligible" 2 "Covered" 3 "Excluded" 4 "Leakage")) ///
    title("Targeting funnel from baseline to follow-up") ///
    ytitle("Households") ///
    bar(1, color(navy)) graphregion(color(white))
graph export "${FIGS}/targeting_funnel.png", replace width(1600)

import delimited using "${TABLES}/payment_reliability_summary.csv", clear varnames(1)
graph hbar mean_delay_days, over(provider, sort(mean_delay_days) descending) ///
    title("Mean payment delay by provider") ///
    ytitle("Days") ///
    bar(1, color(navy)) graphregion(color(white))
graph export "${FIGS}/payment_provider_delay.png", replace width(1600)

import delimited using "${TABLES}/welfare_change_summary.csv", clear varnames(1)
rename indicator metric
rename change value
graph bar value, over(metric) ///
    title("Descriptive changes from baseline to follow-up") ///
    ytitle("Change") ///
    note("Descriptive only; not a causal impact estimate.") ///
    bar(1, color(eltblue)) graphregion(color(white))
graph export "${FIGS}/welfare_change.png", replace width(1600)

import delimited using "${TABLES}/enumerator_quality_summary.csv", clear varnames(1)
gsort -short_duration_rate
keep in 1/8
graph hbar short_duration_rate, over(enum_id, sort(short_duration_rate) descending) ///
    title("Survey duration flags are concentrated") ///
    ytitle("Percent under 15 minutes") ///
    bar(1, color(navy)) graphregion(color(white))
graph export "${FIGS}/enumerator_quality_flags.png", replace width(1600)
