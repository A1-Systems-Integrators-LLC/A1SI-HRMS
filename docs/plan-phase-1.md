# Phase 1 -- Foundation

## Scope

Establish the monorepo scaffold, complete database schema, Auth0 authentication, RBAC, and React Native mobile scaffold.

## Issues

- #1 -- Repo Scaffold (Makefile, CI, Backend + Frontend skeleton)
- #2 -- Database Schema & Migrations (all domain models)
- #3 -- Auth0 Integration (SSO, JWT, RBAC, API keys)
- #4 -- React Native Mobile Scaffold
- #5 -- Epic
- #26 -- INFRA: CI workflow (PAT scope issue)

## Key Decisions

- **PostgreSQL** over SQLite: multi-user concurrent access required
- **django-treebeard MP_Node**: unlimited depth trees for org chart and projects
- **Auth0**: enterprise-grade SSO, avoids building auth from scratch
- **API keys**: per-user keys for MCP server authentication (bcrypt-hashed)
- **Employee extends User via OneToOneField**: avoids AbstractUser migration issues

## Dependencies

None -- this is the first phase. Everything else depends on this.

## Risks

- Auth0 configuration complexity (callback URLs, audience, JWKS caching)
- React Native + Auth0 native module setup can be finicky on first setup
- PAT missing `workflow` scope blocks CI pipeline push
