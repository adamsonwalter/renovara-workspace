# Renovara NEM Skills Package — Owner's Guide

Version: 2.0 — 2026-06-12 | For: Walter Adamson
Companion files: `ORCHESTRATOR.md` (routing layer), `MCP_SETUP.md` (live data connection — this environment, no CLI), `DOWNLOAD_AND_IMPLEMENTATION_PLAN.md` + `VERSIONS.md` (provenance), `CHANGELOG.md` + `DECISIONS.md` (folder history).

## What you have
Seven self-contained AI skill modules that turn a general-purpose assistant into a domain-aware analyst of the Australian National Electricity Market. Each bundles the three things generic AI lacks: the `external_data.nemweb` schema knowledge, NEM-specific conventions (AEST settlement time, 5-minute dispatch intervals, power vs energy, region IDs), and a disciplined question-to-table routing workflow. The practical effect is the difference between an assistant that guesses at SQL and one that writes correct queries against the right tables first time.

The package operates in two modes. In draft mode (today), it produces validated SQL, table-selection rationale, and analysis structure without touching live data — already useful for designing analyses and briefing people who do have Databricks access. In live mode (after `MCP_SETUP.md`), it executes those queries and returns answers, charts, and reports end-to-end. One module — the AER market agent — needs no connection at all and works fully now, including building PPTX reports from bundled AER data.

## Folder layout
`skills/` holds the six installed modules from the actively developed `agents` repo and is what the orchestrator routes to. `repos/` holds pristine upstream clones (including the legacy `nem-analyst-skill`, kept as a fallback schema reference). `releases/` and `scripts/` support syncing; you never need to run the scripts — ask Claude to re-sync instead.

## The capability map
General market analysis (M1) answers regional price, demand, and volatility questions and is the workhorse. The two DUID modules (M2, M3) profile individual generators — output, performance, revenue — with M3 specialised for wind and solar including capacity factors. Constraint analysis (M4) is the most commercially interesting: it separates forced curtailment (network constraints) from economic curtailment (negative prices) for semi-scheduled renewables — a distinction that drives asset valuation and dispute arguments. The FCAS module (M5) covers frequency-control ancillary services, where revenue stacking increasingly decides battery economics. The AER agent (M6) supplies regulatory and market-body context offline. M7 is legacy fallback only.

## Where the leverage is
The compounding asset isn't any single answer — it's that analysis workflows become repeatable and delegable. The opportunities stack in this order:

**Productised recurring reports.** A weekly volatility brief, a monthly curtailment report per wind farm, an FCAS revenue tracker — each is a one-time prompt against the orchestrator that then runs on demand, or on a schedule in this environment. What an energy consultancy bills days for becomes a re-runnable artifact.

**Advisory wedge for your consulting practice.** Curtailment attribution (M4) and FCAS participation analysis (M5) answer questions asset owners, financiers, and developers pay for: "why did my asset earn less than forecast — was it the network or the market?" Paired with your existing diagnostic and due-diligence skills, this gives you an energy-sector DD capability generalist consultants don't carry.

**A template for vertical AI packages.** Renovara's structure — schema references + routing rules + workflow per skill — is exactly the pattern for converting any data-rich domain into a skills package. Operating this one teaches you to build equivalents for clients on their own warehouses.

## How to use it, day one
Start a session, reference `ORCHESTRATOR.md`, and ask a market question in plain English ("compare SA and VIC price volatility this quarter", "how much was Snowtown curtailed last month and why"). The orchestrator routes, the module governs the SQL, and every figure is tagged CONFIRMED/DRAFT so you know whether it came from live data. Until the MCP is connected, treat outputs as analysis designs; after connection, as answers.

## Maintenance
The `agents` repo is actively developed (last update Jun 2026) — ask Claude to re-sync monthly against the SHAs in `VERSIONS.md`; the legacy repo quarterly. Both are MIT-licensed, so embedding in client deliverables is permitted with attribution. Record every folder change in `CHANGELOG.md` and every non-obvious choice in `DECISIONS.md`.

## The one thing to build today
Connect the MCP (Option A in `MCP_SETUP.md`) and run the smoke test — average NSW1 RRP by hour, last 7 days. Every opportunity above is gated behind live mode; a working connection today compounds into every report, brief, and client engagement that follows.
