/* Clean, validate, and construct the household analysis panel. */

version 17.0

capture file close dq
file open dq using "${QA}/stata_data_quality_notes.md", write replace
file write dq "# Stata Data Quality Notes" _n _n

* --------------------------- Baseline master ---------------------------
use "${INT}/households_baseline_raw.dta", clear
file write dq "## Baseline household data" _n _n
file write dq "- Raw baseline rows: " %9.0fc (_N) _n

duplicates tag hhid, gen(dup_hhid)
count if dup_hhid > 0
file write dq "- Rows involved in duplicate household IDs: " %9.0fc (r(N)) _n

destring urban hh_size female_head disability_member children_under5 ///
    school_age_children eligible_baseline food_insecurity_score_bl ///
    school_attendance_rate_bl health_visit_last_month_bl proxy_means_score, replace force

gen flag_bad_hh_size = hh_size <= 0 | hh_size > 20
gen flag_missing_pmt = missing(proxy_means_score)
count if flag_bad_hh_size
file write dq "- Implausible household-size rows: " %9.0fc (r(N)) _n
count if flag_missing_pmt
file write dq "- Missing PMT rows: " %9.0fc (r(N)) _n

sort hhid survey_date_bl enum_id_bl
by hhid: gen baseline_record_rank = _n
preserve
    keep if dup_hhid > 0
    export delimited using "${TABLES}/duplicate_hhid_review.csv", replace
restore

keep if baseline_record_rank == 1
isid hhid
save "${INT}/baseline_master_clean.dta", replace
file write dq "- Baseline rows after duplicate resolution: " %9.0fc (_N) _n _n

* --------------------------- Follow-up survey ---------------------------
use "${INT}/households_followup_raw.dta", clear
destring food_insecurity_score_fu school_attendance_rate_fu ///
    health_visit_last_month_fu received_transfer_self_report grievance_awareness ///
    satisfaction_score, replace force
duplicates report hhid
isid hhid
save "${INT}/followup_clean.dta", replace

* --------------------------- Payments ----------------------------------
use "${INT}/payments_raw.dta", clear
destring payment_cycle transfer_amount_expected transfer_amount_paid failed_payment, replace force
gen scheduled_dt = date(scheduled_date, "YMD")
gen actual_dt = date(actual_date, "YMD")
format scheduled_dt actual_dt %td
gen payment_delay_days = actual_dt - scheduled_dt if !missing(actual_dt)
gen paid_any = transfer_amount_paid > 0
gen expected_payment = transfer_amount_expected > 0
gen underpaid_cycle = expected_payment == 1 & failed_payment == 0 & transfer_amount_paid < transfer_amount_expected
isid hhid payment_cycle
save "${INT}/payments_clean.dta", replace

preserve
    collapse (count) payment_cycles=payment_cycle ///
        (sum) expected_cycles=expected_payment paid_cycles=paid_any ///
        failed_payment_count=failed_payment underpaid_cycle_count=underpaid_cycle ///
        (mean) payment_delay_mean=payment_delay_days, by(hhid)
    gen received_admin = paid_cycles > 0
    save "${INT}/payments_household_summary.dta", replace
restore

* --------------------------- Survey logs --------------------------------
use "${INT}/survey_logs_raw.dta", clear
destring duration_minutes consent refusal gps_accuracy module_missing_count dont_know_count, replace force
gen flag_short_duration = duration_minutes < 15
gen flag_high_dont_know = dont_know_count >= 5
gen flag_module_missing = module_missing_count >= 2
isid submission_id
save "${INT}/survey_logs_clean.dta", replace

preserve
    keep if round == "followup"
    bysort hhid (submission_id): keep if _n == 1
    keep hhid enum_id duration_minutes dont_know_count module_missing_count flag_short_duration flag_high_dont_know flag_module_missing
    rename enum_id enum_id_fu_log
    save "${INT}/survey_logs_household.dta", replace
restore

* --------------------------- Back-checks and field visits ----------------
use "${INT}/backchecks_raw.dta", clear
destring respondent_confirmed hh_size_bc received_transfer_bc key_discrepancy_count requires_followup, replace force
collapse (count) backcheck_count=requires_followup (sum) backcheck_followup_required=requires_followup ///
    (mean) mean_key_discrepancy=key_discrepancy_count, by(hhid)
save "${INT}/backchecks_household.dta", replace

use "${INT}/field_visits_raw.dta", clear
destring resolved, replace force
gen open_high_severity_visit = issue_severity == "high" & resolved == 0
collapse (count) field_visit_count=resolved (sum) open_high_severity_visit=open_high_severity_visit, by(hhid)
save "${INT}/field_visits_household.dta", replace

* --------------------------- Household panel ----------------------------
use "${INT}/baseline_master_clean.dta", clear
merge 1:1 hhid using "${INT}/followup_clean.dta", gen(m_fu)
gen followup_observed = m_fu == 3
drop m_fu

merge 1:1 hhid using "${INT}/payments_household_summary.dta", gen(m_pay)
foreach v in payment_cycles expected_cycles paid_cycles failed_payment_count underpaid_cycle_count received_admin {
    replace `v' = 0 if missing(`v')
}
drop m_pay

merge 1:1 hhid using "${INT}/survey_logs_household.dta", gen(m_logs)
foreach v in flag_short_duration flag_high_dont_know flag_module_missing dont_know_count module_missing_count {
    replace `v' = 0 if missing(`v')
}
drop m_logs

merge 1:1 hhid using "${INT}/backchecks_household.dta", gen(m_bc)
replace backcheck_followup_required = 0 if missing(backcheck_followup_required)
drop m_bc

merge 1:1 hhid using "${INT}/field_visits_household.dta", gen(m_visit)
replace open_high_severity_visit = 0 if missing(open_high_severity_visit)
drop m_visit

gen coverage_eligible = eligible_baseline == 1 & received_admin == 1
gen exclusion_eligible = eligible_baseline == 1 & received_admin == 0
gen leakage_ineligible = eligible_baseline == 0 & received_admin == 1
gen admin_self_report_mismatch = received_admin != received_transfer_self_report if followup_observed
replace admin_self_report_mismatch = 0 if missing(admin_self_report_mismatch)
gen food_insecurity_change = food_insecurity_score_fu - food_insecurity_score_bl if followup_observed
gen school_attendance_change = school_attendance_rate_fu - school_attendance_rate_bl if followup_observed
gen flag_any_quality_issue = dup_hhid > 0 | flag_bad_hh_size | flag_missing_pmt | ///
    flag_short_duration | flag_high_dont_know | flag_module_missing | ///
    admin_self_report_mismatch | backcheck_followup_required > 0 | open_high_severity_visit > 0

isid hhid
save "${PROC}/analysis_household_panel.dta", replace
export delimited using "${PROC}/analysis_household_panel.csv", replace

preserve
    keep if flag_any_quality_issue
    gen priority = cond(open_high_severity_visit > 0 | backcheck_followup_required > 0 | failed_payment_count >= 2, "high", "medium")
    gen str200 reason = ""
    replace reason = reason + "admin/self-report mismatch; " if admin_self_report_mismatch
    replace reason = reason + "short survey duration; " if flag_short_duration
    replace reason = reason + "back-check follow-up; " if backcheck_followup_required > 0
    replace reason = reason + "open high-severity visit; " if open_high_severity_visit > 0
    replace reason = reason + "repeated failed payment; " if failed_payment_count >= 2
    keep hhid district priority reason
    export delimited using "${PROC}/data_quality_flags.csv", replace
    export delimited using "${TABLES}/field_followup_list.csv", replace
restore

file close dq
