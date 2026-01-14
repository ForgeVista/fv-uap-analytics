# fv-uap-analytics (Agent / Developer Notes)

## Purpose
Template repo for per-project analytics using DuckDB + Evidence.dev.

## Structure

```
.
├── bootstrap.sh
├── evidence.config.yaml
├── pages/
│   ├── index.md
│   ├── examples/
│   │   └── sample-query.md
│   └── queries/
│       └── index.md
├── queries/
│   └── sample.sql
└── sources/
    └── duckdb/
        ├── connections.yaml
        ├── connection.yaml
        └── README.md
```

## DuckDB Connection

Evidence reads data sources from `sources/<name>/`.

- `connections.yaml` is the primary config file
- `connection.yaml` is included for compatibility with older Evidence versions
- `connection.options.yaml` is created by Evidence for secrets (if needed)

Example (DuckDB):

```yaml
type: duckdb
name: duckdb
options:
  filename: analytics.duckdb
```

## Evidence Configuration

`evidence.config.yaml` sets UI appearance defaults and leaves deployment settings optional.

- To set a build output directory, use `EVIDENCE_BUILD_DIR`
- To change the dev server port, use `EVIDENCE_PORT`

## Bootstrap Script

`bootstrap.sh` is idempotent and follows a check/install pattern:

- Checks for Git, Node.js 16+, npm, DuckDB CLI, Evidence.dev
- Installs missing tools using OS package managers
- Fails fast with clear manual install links if unsupported

## Supported Platforms

- macOS (Homebrew)
- Linux (apt, dnf, pacman)
- Windows: WSL recommended (native installs are out of scope)

## Version Requirements

- Node.js 16+
- Evidence.dev (latest via npm)
- DuckDB CLI (latest stable)

## Developer Notes

- `queries/` holds reusable SQL files for Evidence
- `pages/` holds dashboard pages (Markdown)
- Keep the template free of secrets and real data
