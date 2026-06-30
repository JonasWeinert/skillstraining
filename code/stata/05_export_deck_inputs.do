/* Export a neutral inventory of deck source files. */

version 17.0

capture file close inv
file open inv using "${QA}/deck_source_inventory.md", write replace
file write inv "# Deck Source Inventory" _n _n
file write inv "Use these generated Stata outputs when updating the baseline deck." _n _n
file write inv "## Tables" _n _n
file write inv "- `outputs/tables/targeting_summary.csv`" _n
file write inv "- `outputs/tables/payment_reliability_summary.csv`" _n
file write inv "- `outputs/tables/welfare_change_summary.csv`" _n
file write inv "- `outputs/tables/enumerator_quality_summary.csv`" _n _n
file write inv "## Figures" _n _n
file write inv "- `outputs/figures/targeting_funnel.png`" _n
file write inv "- `outputs/figures/payment_provider_delay.png`" _n
file write inv "- `outputs/figures/welfare_change.png`" _n
file write inv "- `outputs/figures/enumerator_quality_flags.png`" _n
file close inv

log close

