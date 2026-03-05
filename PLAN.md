# A1SI-HRMS -- Architecture & Phase Roadmap

## Vision

Replace Connecteam with an AI-native HR management platform that handles time tracking, payroll calculation, equity management, and reporting. The platform exposes an MCP server so AI assistants can log hours, query data, and generate reports on behalf of authenticated users.

## Technology Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Backend framework | Django 5.x + DRF | Match A1SI-AITP patterns, mature ecosystem |
| Database | PostgreSQL | Multi-user concurrent access (not SQLite) |
| Frontend | React 19 + TypeScript + Vite 6 + Tailwind v4 | Match A1SI-AITP, modern tooling |
| Mobile | React Native | Shared React mental model, push notification support |
| Auth | Auth0 + JWT | SSO, enterprise-grade, RBAC |
| MCP | Model Context Protocol server | AI-native integration for time/project management |
| Hierarchy model | MPTT or django-treebeard | Unlimited depth for both org chart and project trees |
| Payroll | In-house calculation engine | Gross pay, deductions, overtime, tips, tax rates |
| Equity | Quarterly allocation engine + cap table export | Carta/Pulley API integration |
| Certified payroll | WH-347 form generation | Davis-Bacon Act compliance for government contracts |

## Architecture

### Backend Django Apps

| App | Responsibility |
|-----|---------------|
| `core` | Auth0 integration, JWT validation, RBAC, health checks, management hierarchy (org chart) |
| `employees` | Employee profiles, pay rates (hourly, project-specific), classifications (W-2, exempt/non-exempt), deduction configurations |
| `projects` | Project and sub-project tree (unlimited depth), project-specific pay rates |
| `timekeeping` | Clock in/out events, time entries (start/stop per project), shifts, daily/weekly totals |
| `approvals` | Timesheet submission workflow, supervisor approval/rejection, employee edit approval, RBAC-based exemptions |
| `payroll` | Gross pay calculation, overtime rules, tips, deductions (pre-tax, post-tax, garnishments), tax rate management (import + manual) |
| `equity` | Quarterly share allocation by hours, issuance document generation, cap table export |
| `reports` | Hours by employee/project, payroll summaries, certified payroll (WH-347), tax form data export |

### Key Patterns (from A1SI-AITP)

- **Service layer**: Business logic in `app/services/` directories, not in views
- **Async views**: For external API calls (Auth0, Carta, payroll providers)
- **DRF serializers**: Validation and transformation
- **RBAC middleware**: Role and hierarchy-based permission checks
- **Dependency injection**: Services receive dependencies via constructor, not internal instantiation

### Management Hierarchy Model

Unlimited depth tree structure:
- Each employee has an optional `reports_to` foreign key
- RBAC roles: `employee`, `supervisor`, `manager`, `admin`, `owner`
- Supervisors approve timesheets for their direct reports
- Approval chains can be customized per employee (RBAC exemptions)
- Self-approval exemption flag for specific roles

### Time Entry Model

- A time entry = (employee, project, start_time, end_time, notes)
- Multiple entries per day per employee (different projects)
- Shift = scheduled block of time (project, start, end, employee assignment)
- Clock events = real-time in/out with automatic entry creation
- Daily/weekly aggregation computed, not stored

### Payroll Calculation Engine

- Inputs: time entries + pay rates + overtime rules + tips + deductions + tax rates
- Overtime: configurable rules (weekly 40h default, daily 8h for CA, etc.)
- Deductions: typed (federal tax, state tax, FICA, 401k, health, garnishment, custom)
- Output: gross pay, itemized deductions, net pay per pay period
- Export: generic CSV, extensible provider adapters (Gusto, ADP)

## Phase Roadmap

### Phase 1 -- Foundation
Repo scaffold, database schema, Auth0, Django app structure, React Native scaffold.
All other phases depend on this.

### Phase 2 -- Time Tracking Core
Projects/sub-projects, clock in/out (web + mobile), multi-event entries, daily/weekly totals, org chart, RBAC.

### Phase 3 -- Approval Workflows
Timesheet submission/review, supervisor approval/rejection, employee edit approval, exemption rules, shift scheduling + push notifications.

### Phase 4 -- Payroll & Reporting
Pay rates, overtime, tips, deductions, tax rates, gross pay engine, payroll export, reports, certified payroll (WH-347).

### Phase 5 -- Equity & Tax Documents
Quarterly equity allocation, share issuance forms, W-2/tax data export, cap table integration (Carta/Pulley).

### Phase 6 -- MCP Server
MCP scaffold, tools (log hours, query, projects, reports), API key auth, AI-friendly responses.

### Phase 7 -- Polish & Integrations
Mobile feature parity, payroll provider APIs (Gusto/ADP), advanced reporting/dashboard, audit log.

## Compliance Domains

- **Labor law**: FLSA overtime rules, state-specific rules (CA daily overtime)
- **Davis-Bacon Act**: Certified payroll (WH-347) for government contracts
- **Tax**: W-2 data generation, tax rate management, withholding calculations
- **Equity**: SEC compliance for share issuance, 83(b) election tracking
- **Data privacy**: Employee PII handling, access controls, audit logging
