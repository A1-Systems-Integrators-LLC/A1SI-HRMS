# Phase 4 -- Payroll & Reporting

## Scope

Payroll configuration (rates, overtime, deductions, taxes), gross pay calculation engine, payroll export, hours/project/payroll reports, certified payroll (WH-347).

## Issues

- #13 -- Pay Rates, Overtime, Tips & Deductions Configuration
- #14 -- Gross Pay Calculation Engine & Export
- #15 -- Reports (Hours, Payroll, Certified Payroll)
- #16 -- Epic
- #27 -- COMPLIANCE: Labor law, certified payroll, tax, equity compliance

## Key Decisions

- **Calculation order**: regular pay + overtime pay + tips = gross -> pre-tax deductions -> tax -> post-tax deductions = net
- **Overtime classification**: configurable rules with federal (40h/week) and state-specific (CA 8h/day) support
- **Export adapter pattern**: CSVAdapter now, Gusto/ADP adapters in Phase 7. Open/Closed principle.
- **WH-347 compliance**: certified payroll report with all DOL-required fields
- **Tax rate management**: bulk import (CSV) + manual entry with effective dates and brackets

## Dependencies

Phase 3 (approved timesheets needed for payroll calculation)
