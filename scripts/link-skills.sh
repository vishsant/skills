#!/usr/bin/env bash
set -euo pipefail

# Links every non-deprecated skill in this repo into the local skill directories
# each harness reads:
#   ~/.claude/skills  — Claude Code
#   ~/.agents/skills  — Codex and other Agent Skills-compatible harnesses
#
# Entries are symlinks into the repo, so `git pull` keeps installed skills
# current. Re-run after adding, removing, or renaming a skill.
#
# Maintainer convenience, not a supported installer. Users install via the
# Claude Code plugin or `npx skills` — see README.md.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

names=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0)

# Harnesses flatten all skills into one namespace, so a duplicate name here
# means one skill silently shadows the other once linked.
dupes="$(printf '%s\n' "${names[@]}" | sort | uniq -d)"
if [ -n "$dupes" ]; then
  echo "error: duplicate skill names in $REPO/skills:" >&2
  printf '  %s\n' $dupes >&2
  exit 1
fi

for DEST in "${DESTS[@]}"; do
  # A $DEST symlinked into this repo would make us write the per-skill symlinks
  # back into the repo's own skills/ tree.
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO" | "$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
        exit 1
        ;;
    esac
  fi

  mkdir -p "$DEST"

  for i in "${!names[@]}"; do
    name="${names[$i]}"
    src="${srcs[$i]}"
    target="$DEST/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked $name -> $src ($DEST)"
  done
done
