#!/usr/bin/env bash
set -euo pipefail

# Builds .agents/skills as a flat set of symlinks into every skill in this
# repo (including in-progress and misc, excluding deprecated), for local
# testing with `pi` via run.sh. Not installed anywhere outside the repo.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$REPO/.agents/skills"

rm -rf "$DEST"
mkdir -p "$DEST"

while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  ln -sfn "$src" "$DEST/$name"
  echo "linked $name -> $src"
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0)
