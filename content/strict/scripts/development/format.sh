#!/usr/bin/env sh
set -eu
root=$(git rev-parse --show-toplevel)
cd "$root"
dotnet format whitespace --no-restore
