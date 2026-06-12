# Changelog — Renovara workspace

All notable changes to this folder. Newest first. Format: date, change, by.

## 2026-06-12 (session 2)
- Rewrote `README.md` (v2.0) as an owner's guide: capability map, leverage opportunities, day-one usage; removed all CLI instructions.
- Added `ORCHESTRATOR.md` — routing/sequencing layer over the 7 modules (M1–M7) with live/draft mode handling and CONFIRMED/DRAFT/ASSUMED tagging.
- Added `MCP_SETUP.md` — replaced Cursor `.env.example` MCP step with two no-CLI options for this environment (Claude desktop custom connector; direct Databricks SQL Statement Execution API from sandbox).
- Added `VERSIONS.md` — pinned upstream commit SHAs for re-sync checks.
- Added `CHANGELOG.md` and `DECISIONS.md` (this pair).
- Removed duplicate root copies of `agents/` and `nem-analyst-skill/` (identical to `repos/`) and superseded `DOWNLOAD_PLAN.md` (covered by `DOWNLOAD_AND_IMPLEMENTATION_PLAN.md`).

## Earlier (session 1)
- Cloned `Renovara/agents` and `Renovara/nem-analyst-skill` into `repos/`.
- Installed six skill modules into `skills/`; created `scripts/` (clone-all, install-skills, verify), `releases/`, `DOWNLOAD_AND_IMPLEMENTATION_PLAN.md`, original `README.md`.
- Set up `aer-market-agent` Python venv under `repos/agents/skills/aer-market-agent/.venv`.
