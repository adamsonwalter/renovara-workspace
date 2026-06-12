#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAIL=0

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1" >&2; FAIL=1; }

echo "=== Renovara workspace verification ==="

# Repo presence
for repo in agents nem-analyst-skill; do
  if [[ -d "$ROOT/repos/$repo/.git" ]]; then
    pass "repo repos/$repo"
  else
    fail "repo repos/$repo missing"
  fi
done

# NEM skill bundles
NEM_SKILLS=(
  renovara_ai_nem_analyst
  renovara_duid_report_detailed
  renovara_duid_renewable_report_detailed
  renovara_duid_constraint_analysis
  renovara_fcas_analyst
)

for skill in "${NEM_SKILLS[@]}" aer-market-agent; do
  skill_md="$ROOT/repos/agents/skills/$skill/SKILL.md"
  if [[ -f "$skill_md" ]]; then
    pass "SKILL.md $skill"
  else
    fail "SKILL.md $skill"
  fi
done

schema_index="$ROOT/repos/agents/skills/renovara_ai_nem_analyst/references/schema-index.md"
if [[ -f "$schema_index" ]]; then
  pass "schema-index.md (renovara_ai_nem_analyst)"
else
  fail "schema-index.md (renovara_ai_nem_analyst)"
fi

# aer-market-agent smoke test
AER_DIR="$ROOT/repos/agents/skills/aer-market-agent"
if [[ -x "$AER_DIR/.venv/bin/python" ]]; then
  if "$AER_DIR/.venv/bin/python" "$AER_DIR/scripts/query.py" domains >/dev/null 2>&1; then
    pass "aer-market-agent query.py domains"
  else
    fail "aer-market-agent query.py domains"
  fi

  OUT="/tmp/renovara-dmo-report.pptx"
  if "$AER_DIR/.venv/bin/python" "$AER_DIR/scripts/build_report.py" --out "$OUT" >/dev/null 2>&1 && [[ -f "$OUT" ]]; then
    pass "aer-market-agent build_report.py"
  else
    fail "aer-market-agent build_report.py"
  fi
else
  fail "aer-market-agent venv missing (run: cd repos/agents/skills/aer-market-agent && python3 -m venv .venv && .venv/bin/pip install python-pptx matplotlib openpyxl)"
fi

# Workspace skill symlinks
for skill in aer-market-agent "${NEM_SKILLS[@]}"; do
  link="$ROOT/skills/$skill"
  if [[ -L "$link" && -d "$link" ]]; then
    pass "workspace symlink skills/$skill"
  else
    fail "workspace symlink skills/$skill (run scripts/install-skills.sh)"
  fi
done

if [[ "$FAIL" -eq 0 ]]; then
  echo "All checks passed."
else
  echo "Some checks failed." >&2
  exit 1
fi
