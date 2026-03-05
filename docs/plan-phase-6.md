# Phase 6 -- MCP Server

## Scope

Model Context Protocol server for AI assistant integration: time tracking tools, project queries, report generation, API key authentication.

## Issues

- #20 -- MCP Server (scaffold, tools, auth, responses)
- #21 -- Epic

## Key Decisions

- **stdio transport**: MCP server runs as subprocess launched by AI assistant
- **Django ORM direct**: MCP server imports Django settings and uses ORM directly (not HTTP calls)
- **Same service layer**: MCP tools call the same services as web/mobile views
- **API key auth**: user's API key passed via environment variable in MCP config
- **Source=MCP**: all entries created via MCP tagged for audit trail

## MCP Tool Inventory

| Tool | Description |
|------|-------------|
| clock_in | Clock into a project |
| clock_out | Clock out of current project |
| log_hours | Create a time entry for a past date |
| query_hours | Get hour summaries for date range |
| list_projects | List available projects |
| generate_report | Generate a report (hours, payroll) |

## Dependencies

Phase 1 (API keys), Phase 2 (time/project services), Phase 4 (report services)
