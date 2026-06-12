#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${SKILLS_DIR:-$HOME/.cursor/skills}"
INSTALL_NEM_ANALYST_STANDALONE="${INSTALL_NEM_ANALYST_STANDALONE:-0}"

mkdir -p "$SKILLS_DIR" "$ROOT/skills"

AGENT_SKILLS=(
  aer-market-agent
  renovara_ai_nem_analyst
  renovara_duid_report_detailed
  renovara_duid_renewable_report_detailed
  renovara_duid_constraint_analysis
  renovara_fcas_analyst
)

for skill in "${AGENT_SKILLS[@]}"; do
  src="$ROOT/repos/agents/skills/$skill"
  if [[ ! -d "$src" ]]; then
    echo "Missing skill source: $src (run scripts/clone-all.sh first)" >&2
    exit 1
  fi
  ln -sfn "$src" "$ROOT/skills/$skill"
  ln -sfn "$src" "$SKILLS_DIR/$skill"
  echo "Linked $skill -> $SKILLS_DIR/$skill"
done

if [[ "$INSTALL_NEM_ANALYST_STANDALONE" == "1" ]]; then
  src="$ROOT/repos/nem-analyst-skill/nem-analyst"
  ln -sfn "$src" "$ROOT/skills/nem-analyst"
  ln -sfn "$src" "$SKILLS_DIR/nem-analyst"
  echo "Linked nem-analyst (standalone) -> $SKILLS_DIR/nem-analyst"
fi

echo "Skills installed to $SKILLS_DIR"
