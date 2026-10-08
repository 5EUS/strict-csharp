#!/usr/bin/env sh
# Copy/paste detection with PMD CPD. Needs `pmd` (https://pmd.github.io) on PATH.
set -eu
root=$(cd "$(dirname "$0")/../.." && pwd)
cd "$root"

if ! command -v pmd >/dev/null 2>&1; then
  echo "pmd not found; install it (e.g. 'brew install pmd') to run duplicate detection." >&2
  exit 1
fi

# Exits non-zero when duplicates of 100+ tokens are found.
pmd cpd --language cs --minimum-tokens 100 --dir src --dir tests
