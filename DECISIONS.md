# Decision log — Renovara workspace

Non-obvious choices and their rationale. One entry per decision; supersede, don't delete.

## D1 — `skills/` is the canonical routing target; `repos/` is pristine upstream (2026-06-12)
The orchestrator routes to `skills/` (installed copies). `repos/` keeps untouched clones with `.git` for diffing against upstream. Consequence: never hand-edit `skills/`; re-sync from `repos/` instead.

## D2 — Legacy `nem-analyst-skill` retained as M7 fallback only (2026-06-12)
It overlaps with `renovara_ai_nem_analyst` (M1) but was last updated Mar 2026 vs Jun 2026. M1 is authoritative; M7 consulted only when M1 lacks a table reference. Revisit if upstream revives the legacy repo.

## D3 — MCP connection rewritten for Claude desktop, not Cursor (2026-06-12)
Walter does not run CLI. Option A: custom connector in Claude desktop settings (preferred — persistent across sessions). Option B: direct Databricks SQL Statement Execution REST API from the sandbox using a read-only PAT in local `databricks.env` (fallback; subject to sandbox network allowlist). Original Cursor/.env instructions remain valid for other machines but are not the path here.

## D4 — Read-only execution policy (2026-06-12)
Orchestrator only ever uses `execute_sql_read_only`; `execute_sql` requires explicit instruction. NEM data is reference data — no write path is needed, and a read-only PAT caps blast radius.

## D5 — Duplicate root module copies deleted rather than merged (2026-06-12)
Session 2 initially copied repos to the folder root, unaware session 1 had already built `repos/` + `skills/`. Verified byte-identical (diff), then deleted duplicates. Lesson encoded: check existing layout before importing; `CHANGELOG.md` now exists to prevent cross-session blindness.

## D6 — Output trust tagging (2026-06-12)
Every figure in any deliverable carries CONFIRMED (executed), DRAFT (unexecuted SQL), or ASSUMED (synthesised parameter). Prevents draft-mode numbers being mistaken for live data in client-facing material.
