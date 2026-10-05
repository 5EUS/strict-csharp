# strict-C#

A `dotnet new` template for C# projects that fail the build on anything sloppy:
warnings are errors, every analyzer is on, and NativeAOT compatibility is checked
at build time instead of at publish time.

## Install and use

```sh
dotnet new install ./strict-csharp          # from a local checkout
dotnet new strictcommon -n MyApp
```

The generated solution contains a NativeAOT console app under `src/` and an xUnit v3
test project under `tests/`. The project name you pass to `-n` becomes the namespace,
so use a PascalCase name without hyphens (`MyApp`, not `my-app`): the analyzers reject
the underscores a hyphenated name turns into.

## What is enforced

| Area | How |
| --- | --- |
| Warnings | `TreatWarningsAsErrors`, `AnalysisMode=All`, `EnforceCodeStyleInBuild` |
| Nullability | `Nullable=enable`, asserted in `Directory.Build.targets` |
| NativeAOT | AOT, trim and single-file analyzers on; the matching `IL*` rules pinned to `error` |
| Analyzers | StyleCop, Roslynator, Meziantou, Sonar, BannedApiAnalyzers |
| Banned APIs | `BannedSymbols.txt`: reflection emit, `Activator.CreateInstance`, reflection JSON, blocking `Task` calls, `Thread`, `DateTime.Now`/`UtcNow`, MD5, SHA1 |
| Reproducibility | Central package versions, transitive pinning, lock files, deterministic builds, pinned SDK in `global.json` |
| Build posture | `Directory.Build.targets` fails with `STRICT0001`–`STRICT0004` if a project disables nullable, warnings-as-errors, the AOT analyzers or lock files |
| Formatting | `.editorconfig`, checked by `dotnet format whitespace --verify-no-changes` |

All settings live in `Directory.Build.props`, so a `.csproj` stays nearly empty and
cannot quietly opt out. To bypass a banned API, use `#pragma warning disable RS0030`
with a comment naming the reason.

## Workflow

```sh
sh scripts/development/install-git-hooks.sh   # fast pre-commit format check
sh scripts/development/format.sh              # apply formatting
sh scripts/development/check.sh               # everything CI checks
```

CI (`.github/workflows/ci.yml`) restores in locked mode, verifies formatting, builds,
tests, publishes NativeAOT on six OS/architecture runners, and checks for vulnerable
packages. NativeAOT cannot cross-compile, hence one runner per RID.

## Layout

```text
content/strictcommon/
  .template.config/        template definition
  Directory.Build.props    every build setting
  Directory.Build.targets  guards against opting out
  Directory.Packages.props central package versions
  BannedSymbols.txt        banned API list
  src/strictcommon/        NativeAOT console app
  tests/strictcommon.Tests/ xUnit v3 tests
```
