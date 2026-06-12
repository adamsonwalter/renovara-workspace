# Decision Log

## 2026-06-12 — Renovara workspace bootstrap

**Problem:** Empty workspace; needed all public Renovara OSS modules cloned, installed, and verifiable locally.

**Solution:** Monorepo-style hub with `repos/` clones, `skills/` symlinks into source trees, scripts for clone/install/verify, and Cursor skill symlinks under `~/.cursor/skills/`. Canonical NEM general analyst is `renovara_ai_nem_analyst` from `agents` (standalone `nem-analyst-skill` not installed by default).

**Why:** Keeps upstream repos updatable via `git pull`, avoids duplicating skill content, and separates offline (`aer-market-agent`) from MCP-dependent NEM skills.
