#!/usr/bin/env sh
# Everything CI checks, locally. Run before opening a PR.
set -eu
root=$(git rev-parse --show-toplevel)
cd "$root"

dotnet restore --locked-mode
dotnet format whitespace --no-restore --verify-no-changes
dotnet build -c Release --no-restore
dotnet test -c Release --no-build
dotnet list package --vulnerable --include-transitive
