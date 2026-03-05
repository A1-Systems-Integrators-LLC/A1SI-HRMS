# A1SI-HRMS

AI-native HR Management System -- time tracking, payroll calculation, equity management, and MCP server.

Built to replace Connecteam with a fully owned, AI-integrated platform following the same architecture as A1SI-AITP.

## Tech Stack

- **Backend**: Python 3.12, Django 5.x, Django REST Framework, Django Channels (ASGI/Daphne), PostgreSQL
- **Frontend**: TypeScript, React 19, Vite 6, TanStack React Query, Tailwind CSS v4
- **Mobile**: React Native (iOS + Android)
- **Auth**: Auth0 (SSO, JWT), RBAC with arbitrary hierarchy depth
- **MCP Server**: Model Context Protocol server for AI assistant integration
- **Tooling**: Makefile-driven, ruff + mypy (Python), eslint (TS), pytest + vitest

## Architecture

Monorepo with domain-driven Django apps:

```
backend/         Django REST backend
  core/          Auth, health, RBAC, management hierarchy
  employees/     Employee profiles, pay rates, classifications
  projects/      Projects, sub-projects (unlimited depth)
  timekeeping/   Clock in/out, time entries, shifts
  approvals/     Timesheet submission, supervisor review, exemptions
  payroll/       Gross pay, deductions, overtime, tips, tax rates
  equity/        Share allocation, quarterly issuance, cap table export
  reports/       Payroll summaries, project hours, certified payroll (WH-347)
frontend/        React TypeScript web dashboard
mobile/          React Native mobile app
mcp/             MCP server for AI assistant integration
docs/            Architecture docs, phase plans, compliance notes
```

## Quick Start

```bash
make setup   # Install all dependencies, migrate DB, create superuser
make dev     # Start backend + frontend in dev mode
```

## Commands

| Command          | Description                              |
|------------------|------------------------------------------|
| `make help`      | Show all available targets               |
| `make setup`     | Install all dependencies                 |
| `make build`     | Production build                         |
| `make dev`       | Run backend + frontend in dev mode       |
| `make test`      | Run pytest + vitest                      |
| `make lint`      | Run ruff + eslint                        |
| `make static`    | Run mypy type checking                   |
| `make security`  | Run pip-audit + npm audit                |
| `make clean`     | Remove build artifacts and caches        |
| `make migrate`   | Run Django migrations                    |

## Project Structure

See [PLAN.md](PLAN.md) for the full architecture, phase roadmap, and technology decisions.
