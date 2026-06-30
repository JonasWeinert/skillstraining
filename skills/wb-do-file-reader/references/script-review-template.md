# Script Review Template

## Execution Order

List the master do-file and every downstream do-file in order.

## Inputs

List raw CSVs and any assumptions about immutability.

## Outputs

List intermediate `.dta`, processed datasets, tables, figures, logs, and deck inputs.

## Indicator Logic

For each slide-relevant indicator, identify:

- source do-file;
- input variables;
- transformation;
- output table or figure.

## Risks

Flag:

- hardcoded numbers;
- unlogged drops;
- weak merge validation;
- causal wording unsupported by code;
- deck claims without source outputs.

