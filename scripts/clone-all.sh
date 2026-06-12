#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/repos"

clone_if_missing() {
  local url="$1"
  local dest="$2"
  if [[ -d "$dest/.git" ]]; then
    echo "Already cloned: $dest"
    git -C "$dest" pull --ff-only
  else
    git clone "$url" "$dest"
  fi
}

clone_if_missing "https://github.com/Renovara/agents.git" "$ROOT/repos/agents"
clone_if_missing "https://github.com/Renovara/nem-analyst-skill.git" "$ROOT/repos/nem-analyst-skill"

echo "Clone complete."
