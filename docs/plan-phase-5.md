# Phase 5 -- Equity & Tax Documents

## Scope

Quarterly equity allocation engine, share issuance documents, W-2 data export, cap table software integration (Carta, Pulley).

## Issues

- #17 -- Quarterly Equity Allocation & Share Issuance Documents
- #18 -- Tax Form Data Export & Cap Table Integration
- #19 -- Epic

## Key Decisions

- **Proportional allocation**: shares = (employee_hours / total_hours) * total_pool
- **Admin approval required**: allocation is draft -> review -> finalize (no auto-issuance)
- **Legal review step**: equity issuance requires legal sign-off before finalization
- **W-2 data only**: system exports data fields, does not generate IRS-submittable PDFs
- **Cap table adapter pattern**: same interface for Carta and Pulley (Open/Closed)

## Compliance Notes

- SEC exemption filings may be required for share issuance
- 83(b) election tracking may be needed
- W-2 data must be accurate to avoid IRS penalties
- Legal counsel should review equity workflow before production use

## Dependencies

Phase 2 (hours totals for allocation), Phase 4 (payroll data for tax export)
