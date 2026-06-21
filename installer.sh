#!/usr/bin/env bash
# Installs solana-treasury-ops-skill into a target skills directory.
# Usage: ./installer.sh [target_dir]
# Default target_dir: ~/.claude/skills/solana-treasury-ops-skill
set -e

TARGET="${1:-$HOME/.claude/skills/solana-treasury-ops-skill}"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skill"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: skill/ directory not found next to installer.sh"
  exit 1
fi

mkdir -p "$TARGET"
cp -r "$SRC_DIR"/* "$TARGET"/

echo "Installed solana-treasury-ops-skill to $TARGET"
echo "SKILL.md entry point: $TARGET/SKILL.md"
