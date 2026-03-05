# A1SI-HRMS -- Architecture & Phase Roadmap

## Vision

Replace Connecteam with an AI-native HR management platform that handles time tracking, payroll calculation, equity management, and reporting. The platform exposes an MCP server so AI assistants can log hours, query data, and generate reports on behalf of authenticated users.

## Technology Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Backend framework | Django 5.x + DRF | Match A1SI-AITP patterns, mature ecosystem |
| Database | PostgreSQL 16 | Multi-user concurrent access (not SQLite) |
| Frontend | React 19 + TypeScript + Vite 6 + Tailwind v4 | Match A1SI-AITP, modern tooling |
| Mobile | React Native CLI | Full native module access, push notifications |
| Auth | Auth0 + PyJWT (RS256) | SSO, enterprise-grade, direct JWT validation |
| MCP | Model Context Protocol (stdio) | AI-native integration via official MCP Python SDK |
| Tree structures | django-treebeard MP_Node | Unlimited depth for org chart + project hierarchy |
| Payroll | In-house calculation engine | Gross pay, OT classification, deductions, tax withholding |
| Equity | Quarterly allocation engine | Hours-proportional distribution + cap table export |
| Certified payroll | WH-347 PDF generation | Davis-Bacon Act compliance |
| PDF generation | WeasyPrint | Pay stubs, issuance docs, WH-347 forms |
| Push notifications | Firebase Cloud Messaging | Cross-platform (iOS via APNs relay, Android native) |

## Architecture

### Backend Django Apps

| App | Responsibility |
|-----|---------------|
| `core` | Auth0 JWT validation, RBAC (roles + hierarchy), API key management, management hierarchy (org chart via treebeard), audit log, device tokens, health checks |
| `employees` | Employee profiles (OneToOneField -> User), pay rates, classifications (W-2 exempt/non-exempt, 1099), emergency contacts, SSN encryption |
| `projects` | Project tree (unlimited depth via treebeard), project assignments, project codes |
| `timekeeping` | Clock events (in/out), time entries (start/stop per project), shifts, shift templates, daily/weekly totals aggregation |
| `approvals` | Timesheet submissions, approval actions (audit trail), supervisor edit-approval flow, RBAC exemptions |
| `payroll` | Pay configs, overtime rules (FLSA + state), tips, deductions (pre/post-tax), tax tables/brackets, payroll runs, line items, pay stubs |
| `equity` | Equity config, quarterly pools, allocations, positions, issuance documents, cap table adapters |
| `reports` | Hours reports, payroll summaries, certified payroll (WH-347), tax form data export (W-2, 1099-NEC), analytics |

### Key Patterns (from A1SI-AITP)

- **Service layer**: Business logic in `app/services/` directories, never in views
- **Dependency injection**: Services receive dependencies via constructor
- **Adapter pattern**: Export adapters (CSV, JSON, Gusto, ADP), cap table adapters (Carta, Pulley)
- **Immutable audit trail**: AuditLogEntry cannot be updated or deleted
- **Computed aggregations**: Totals computed on-the-fly, not stored
- **DRF serializers**: Validation and transformation
- **RBAC**: Role hierarchy (Owner>Admin>Manager>Supervisor>Employee) + org tree checks

## Issue Inventory (56 feature issues across 7 phases)

### Phase 1 -- Foundation (12 issues: #28-#39)
| Issue | Title |
|-------|-------|
| #28 | P1-01: Monorepo Scaffold |
| #29 | P1-02: GHA CI Workflow |
| #30 | P1-03: Django Project Bootstrap |
| #31 | P1-04: Core Domain Models (Employee, User) |
| #32 | P1-05: Auth0 Integration |
| #33 | P1-06: RBAC Framework |
| #34 | P1-07: API Key Management |
| #35 | P1-08: Management Hierarchy (Org Chart) |
| #36 | P1-09: React Frontend Scaffold |
| #37 | P1-10: React Native Mobile Scaffold |
| #38 | P1-11: Audit Log Framework |
| #39 | P1-12: Employee CRUD API & Admin UI |

### Phase 2 -- Time Tracking Core (10 issues: #41-#50)
| Issue | Title |
|-------|-------|
| #41 | P2-01: Project Domain Model |
| #42 | P2-02: Project CRUD API |
| #43 | P2-03: Project Management Web UI |
| #44 | P2-04: TimeEntry & ClockEvent Models |
| #45 | P2-05: Clock In/Out API |
| #46 | P2-06: Manual Time Entry API |
| #47 | P2-07: Daily/Weekly Totals API |
| #48 | P2-08: Time Tracking Web UI |
| #49 | P2-09: Mobile Clock In/Out Screen |
| #50 | P2-10: Employee & Supervisor Dashboard |

### Phase 3 -- Approval Workflows (8 issues: #51-#58)
| Issue | Title |
|-------|-------|
| #51 | P3-01: Shift Domain Model |
| #52 | P3-02: Shift Scheduling API |
| #53 | P3-03: Shift Schedule Web UI |
| #54 | P3-04: Timesheet Submission & Approval Models |
| #55 | P3-05: Timesheet Submission & Approval API |
| #56 | P3-06: Supervisor Edit-Approval Flow |
| #57 | P3-07: Approval Workflow Web UI |
| #58 | P3-08: Mobile Approval & Schedule Screens |

### Phase 4 -- Payroll & Reporting (10 issues: #59-#68)
| Issue | Title |
|-------|-------|
| #59 | P4-01: Pay Configuration Models |
| #60 | P4-02: Tax Rate Management |
| #61 | P4-03: Deduction Configuration |
| #62 | P4-04: Overtime Calculation Engine |
| #63 | P4-05: Gross Pay Calculation Service |
| #64 | P4-06: Deduction & Tax Withholding Service |
| #65 | P4-07: PayrollRun Model & API |
| #66 | P4-08: Payroll Export & Pay Stubs |
| #67 | P4-09: Reports (Hours, Payroll, WH-347) |
| #68 | P4-10: Payroll Admin UI |

### Phase 5 -- Equity & Tax Documents (6 issues: #69-#74)
| Issue | Title |
|-------|-------|
| #69 | P5-01: Equity Domain Models |
| #70 | P5-02: Quarterly Equity Allocation Engine |
| #71 | P5-03: Share Issuance Document Generation |
| #72 | P5-04: W-2 / 1099-NEC Tax Data Export |
| #73 | P5-05: Cap Table Integration (Carta/Pulley) |
| #74 | P5-06: Equity & Tax Documents Web UI |

### Phase 6 -- MCP Server (4 issues: #75-#78)
| Issue | Title |
|-------|-------|
| #75 | P6-01: MCP Server Scaffold & Auth |
| #76 | P6-02: MCP Tools -- Time Tracking |
| #77 | P6-03: MCP Tools -- Projects & Reports |
| #78 | P6-04: MCP Resources & Documentation |

### Phase 7 -- Polish & Integrations (6 issues: #79-#84)
| Issue | Title |
|-------|-------|
| #79 | P7-01: Gusto API Adapter |
| #80 | P7-02: ADP API Adapter |
| #81 | P7-03: Mobile Feature Parity |
| #82 | P7-04: Advanced Analytics Dashboard |
| #83 | P7-05: Audit Log Web UI |
| #84 | P7-06: Performance & Security Hardening |

## Compliance Domains

- **FLSA**: Overtime rules (weekly 40h federal, daily 8h CA), exempt/non-exempt tracking, record retention (3 years payroll, 2 years time cards)
- **Davis-Bacon Act**: Certified payroll WH-347 form, prevailing wage rates, statement of compliance
- **Tax**: W-2 data accuracy (IRS penalties for errors), FICA wage base cap, state tax withholding
- **Equity**: SEC exemption filings for share issuance, state blue sky laws, 83(b) election tracking
- **Data privacy**: Employee PII encryption (SSN), RBAC access controls, immutable audit logging, no PII in logs

## UX Design Principles

- **Clock in/out is the hero**: Large, prominent, one-tap on web and mobile
- **Role-based views**: Dashboard adapts to employee/supervisor/admin role
- **Approval-driven workflow**: Submit -> Review -> Approve/Reject with comment
- **Tree navigation**: File-browser pattern for projects and org chart
- **Mobile-first time entry**: Thumb-friendly buttons, haptic feedback, offline-resilient
- **Calendar views**: Week/month for shift scheduling
- **Progressive disclosure**: Simple views by default, detail on demand
