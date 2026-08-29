#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
./scripts/link-skills-local.sh
exec pi --no-skills --skill .agents/skills "$@"
