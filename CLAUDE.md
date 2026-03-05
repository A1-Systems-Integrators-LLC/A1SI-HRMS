# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project

A1SI-HRMS -- AI-native HR Management System with time tracking, payroll calculation, equity management, and MCP server integration. Replaces Connecteam for employee time/project tracking.

## Tech Stack

- **Backend**: Python 3.12, Django 5.x, Django REST Framework, Django Channels (ASGI/Daphne), PostgreSQL
- **Frontend**: TypeScript, React 19, Vite 6, TanStack React Query, Tailwind CSS v4
- **Mobile**: React Native (iOS + Android)
- **Auth**: Auth0 (SSO, JWT), RBAC with arbitrary hierarchy depth, API keys for MCP
- **Tooling**: Makefile-driven, ruff + mypy (Python), eslint (TS), pytest + vitest

## Architecture

- **Monorepo**: `backend/` + `frontend/` + `mobile/` + `mcp/`
- **Database**: PostgreSQL (multi-user concurrent access)
- **Auth**: Auth0 JWT tokens, RBAC middleware, management hierarchy for approval chains
- **ASGI**: Django Channels + Daphne server, async views for external API calls
- **Django apps**: core, employees, projects, timekeeping, approvals, payroll, equity, reports
- **Service layer**: Business logic in `app/services/` directories -- never in views
- **Frontend served by nginx in prod**, Vite dev proxy in development
- **MCP server**: Standalone service with API key auth per user

## Commands

```bash
make setup          # Install all deps, migrate DB, create superuser
make dev            # Backend :8000 (Daphne) + frontend :5173 (Vite proxies API)
make test           # pytest + vitest
make lint           # ruff check + eslint
make static         # mypy type checking
make build          # Production build
make migrate        # makemigrations + migrate
make security       # pip-audit + npm audit
make clean          # Remove build artifacts and caches
```

## Key Paths

- Backend Django apps: `backend/core/`, `backend/employees/`, `backend/projects/`, `backend/timekeeping/`, `backend/approvals/`, `backend/payroll/`, `backend/equity/`, `backend/reports/`
- Django settings: `backend/config/settings.py`
- Django URLs: `backend/config/urls.py`
- Backend tests: `backend/tests/`
- Frontend source: `frontend/src/`
- Mobile source: `mobile/`
- MCP server: `mcp/`
- Architecture docs: `docs/`
- Phase plans: `docs/plan-phase-*.md`

## Conventions

- Python: ruff formatting, type hints everywhere, async def for IO-bound operations
- TypeScript: strict mode, named exports, functional components
- Dependencies injected via constructor/parameter -- never instantiate internally
- Business logic in service layer, not in views or serializers
- New public API surfaces require tests (happy path + at least one failure path)
- RBAC enforced at both view level (permissions) and service level (hierarchy checks)
