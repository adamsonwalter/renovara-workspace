# Databricks SQL MCP — Setup for This Environment (Claude desktop / Cowork)

Replaces the original "configure in Cursor with `.env.example`" step. You run no CLI at any point.

## What the skills expect
Tools named:
- `mcp__renovara-sql__execute_sql_read_only`
- `mcp__renovara-sql__execute_sql`
- `mcp__renovara-sql__poll_sql_result`

These come from Renovara's Databricks SQL MCP server, pointed at the `external_data.nemweb` catalog.

## Option A — Custom connector in Claude desktop (recommended)
1. Get from Renovara: the MCP server URL (remote/HTTP endpoint) and an access token or OAuth login. If they only ship a local `.env.example`-based server, ask them for the hosted endpoint — Claude desktop connects to remote MCP servers directly.
2. Claude desktop → **Settings → Connectors → Add custom connector**.
3. Name it `renovara-sql`, paste the server URL, complete the auth prompt.
4. Restart the chat session; tell Claude "run the live NEM smoke test".
5. Smoke test: *Show average NSW1 RRP by hour for the last 7 days.* A table of ~168 rows confirms live mode.

## Option B — Direct Databricks REST API (no MCP server needed)
If Renovara can't host the MCP server, Claude can call the Databricks SQL Statement Execution API itself from this session's sandbox:
1. You provide three values (save them in a file `databricks.env` in this folder — Claude will read it, never echo the token back):
   - `DATABRICKS_HOST` (e.g. `https://xxx.cloud.databricks.com`)
   - `DATABRICKS_WAREHOUSE_ID`
   - `DATABRICKS_TOKEN` (a read-only PAT scoped to `external_data.nemweb`)
2. Claude runs queries via the `/api/2.0/sql/statements` endpoint and polls results — functionally identical to the read-only MCP tool.
3. Caveat: the sandbox has an allowlisted network; if your Databricks host is blocked, Claude will tell you on first attempt and Option A is the path.

## Security notes
- Use a read-only token; the orchestrator never calls write paths anyway.
- `databricks.env` stays in this local folder. Don't commit it anywhere; it's already a good idea to add it to any future `.gitignore`.

## Until configured
Draft mode works today: schema guidance + validated SQL for M1–M5, M7. `aer-market-agent` (M6) is fully functional offline.
