# Phase 2 -- Time Tracking Core

## Scope

Projects/sub-projects CRUD, clock in/out (web + mobile), multi-event time entries, daily/weekly totals, org chart management.

## Issues

- #6 -- Projects & Sub-Projects CRUD
- #7 -- Clock In/Out & Multi-Event Time Entries
- #8 -- Daily/Weekly Totals & Org Chart
- #9 -- Epic

## Key Decisions

- **Computed totals** (not stored): daily/weekly totals aggregated via ORM, not denormalized
- **ClockEvent + TimeEntry separation**: ClockEvents are raw in/out events, TimeEntries are the computed work blocks
- **Source tracking**: every clock event and time entry records its source (WEB, MOBILE, MCP)
- **Project switch**: single API call that closes current entry and opens new one (atomic)

## Dependencies

Phase 1 (all issues must be complete: models, auth, scaffold)
