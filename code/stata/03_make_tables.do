/* Generate CSV tables from the processed household panel and payments. */

version 17.0

use "${PROC}/analysis_household_panel.dta", clear

tempname posth
postfile `posth' str40 indicator double value str20 unit using "${INT}/targeting_summary_tmp.dta", replace
quietly count
post `posth' ("Baseline households") (r(N)) ("households")
quietly count if eligible_baseline == 1
local eligible = r(N)
post `posth' ("Eligible at baseline") (`eligible') ("households")
quietly count if eligible_baseline == 1 & coverage_eligible == 1
post `posth' ("Coverage among eligible") (100 * r(N) / `eligible') ("percent")
quietly count if eligible_baseline == 1 & exclusion_eligible == 1
post `posth' ("Exclusion among eligible") (100 * r(N) / `eligible') ("percent")
quietly count if eligible_baseline == 0
local ineligible = r(N)
quietly count if eligible_baseline == 0 & leakage_ineligible == 1
post `posth' ("Leakage to ineligible") (100 * r(N) / `ineligible') ("percent")
quietly count
local all = r(N)
quietly count if followup_observed == 1
post `posth' ("Follow-up response rate") (100 * r(N) / `all') ("percent")
postclose `posth'
use "${INT}/targeting_summary_tmp.dta", clear
format value %9.1f
export delimited using "${TABLES}/targeting_summary.csv", replace

use "${INT}/payments_clean.dta", clear
keep if expected_payment == 1
collapse (count) eligible_cycles=payment_cycle ///
    (mean) failed_payment_rate=failed_payment underpayment_rate=underpaid_cycle ///
    mean_delay_days=payment_delay_days, by(provider)
replace failed_payment_rate = 100 * failed_payment_rate
replace underpayment_rate = 100 * underpayment_rate
format failed_payment_rate underpayment_rate mean_delay_days %9.1f
export delimited using "${TABLES}/payment_reliability_summary.csv", replace
export delimited using "${PROC}/payment_reliability_summary.csv", replace

use "${PROC}/analysis_household_panel.dta", clear
keep if followup_observed == 1
quietly summarize food_insecurity_score_bl
local food_bl = r(mean)
quietly summarize food_insecurity_score_fu
local food_fu = r(mean)
quietly summarize food_insecurity_change
local food_ch = r(mean)
quietly summarize school_attendance_rate_bl
local school_bl = r(mean)
quietly summarize school_attendance_rate_fu
local school_fu = r(mean)
quietly summarize school_attendance_change
local school_ch = r(mean)

tempname welfare
postfile `welfare' str40 indicator double baseline followup change str30 interpretation using "${INT}/welfare_change_tmp.dta", replace
post `welfare' ("Food insecurity score") (`food_bl') (`food_fu') (`food_ch') ("Lower is better")
post `welfare' ("School attendance rate") (`school_bl') (`school_fu') (`school_ch') ("Higher is better")
postclose `welfare'
use "${INT}/welfare_change_tmp.dta", clear
format baseline followup change %9.1f
export delimited using "${TABLES}/welfare_change_summary.csv", replace

use "${INT}/survey_logs_clean.dta", clear
collapse (count) submissions=consent ///
    (mean) short_duration_rate=flag_short_duration high_dont_know_rate=flag_high_dont_know module_missing_rate=flag_module_missing, by(enum_id)
foreach v in short_duration_rate high_dont_know_rate module_missing_rate {
    replace `v' = 100 * `v'
}
format short_duration_rate high_dont_know_rate module_missing_rate %9.1f
export delimited using "${TABLES}/enumerator_quality_summary.csv", replace
