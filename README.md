# Renovara workspace

Local aggregation hub for [Renovara OSS modules](https://github.com/Renovara/).

## Modules

| Module | Path | Live data |
|--------|------|-----------|
| `aer-market-agent` | `repos/agents/skills/aer-market-agent` | Offline (bundled AER data) |
| `renovara_ai_nem_analyst` | `repos/agents/skills/renovara_ai_nem_analyst` | Databricks MCP |
| `renovara_duid_report_detailed` | `repos/agents/skills/renovara_duid_report_detailed` | Databricks MCP |
| `renovara_duid_renewable_report_detailed` | `repos/agents/skills/renovara_duid_renewable_report_detailed` | Databricks MCP |
| `renovara_duid_constraint_analysis` | `repos/agents/skills/renovara_duid_constraint_analysis` | Databricks MCP |
| `renovara_fcas_analyst` | `repos/agents/skills/renovara_fcas_analyst` | Databricks MCP |
| `nem-analyst` (optional) | `repos/nem-analyst-skill/nem-analyst` | Databricks MCP |

See [DOWNLOAD_AND_IMPLEMENTATION_PLAN.md](./DOWNLOAD_AND_IMPLEMENTATION_PLAN.md) for full details.

## Quick start

```bash
# Clone or update upstream repos
./scripts/clone-all.sh

# Install skill symlinks (default: ~/.cursor/skills)
./scripts/install-skills.sh

# aer-market-agent Python env (one-time)
cd repos/agents/skills/aer-market-agent
python3 -m venv .venv
source .venv/bin/activate
pip install python-pptx matplotlib openpyxl

# Verify everything
./scripts/verify.sh
```

## aer-market-agent (offline)

```bash
cd repos/agents/skills/aer-market-agent
source .venv/bin/activate
python scripts/build_report.py --out /tmp/DMO-Report.pptx
python scripts/query.py domains
python scripts/query.py search "network revenue"
```

## NEM skills (Databricks MCP)

NEM skills need the Renovara Databricks SQL MCP server. Copy `.env.example` to `.env` and fill in credentials, then configure MCP in Cursor.

Expected MCP tools:

- `mcp__renovara-sql__execute_sql_read_only`
- `mcp__renovara-sql__execute_sql`
- `mcp__renovara-sql__poll_sql_result`

Smoke-test prompt once MCP is configured:

```
Show average NSW1 RRP by hour for the last 7 days.
```

Without MCP, skills still provide schema guidance and SQL drafts.

## Update

```bash
./scripts/clone-all.sh
./scripts/install-skills.sh
./scripts/verify.sh
```
