# AI Context: fv-uap-analytics

This repository is a **public template** for per-project analytics using DuckDB + Evidence.dev.

## Goals
- Keep setup simple for non-technical consultants
- Provide a clean starter dashboard structure
- Avoid secrets or real data in the template

## Key Files
- `bootstrap.sh`: idempotent installer/checker
- `evidence.config.yaml`: Evidence UI config (appearance, deployment optional)
- `sources/duckdb/`: DuckDB connection config
- `pages/`: Evidence dashboard pages
- `queries/`: reusable SQL

## Conventions
- Prefer clear, step-by-step documentation
- Use portable shell scripts (macOS + Linux)
- Windows support via WSL only
- Avoid changing Evidence defaults unless justified

## Local Dev
```bash
./bootstrap.sh
EVIDENCE_PORT=3001 evidence dev
```

## Do Not
- Add secrets, tokens, or private data
- Assume network connectivity beyond npm installs
- Add heavy dependencies beyond Evidence/DuckDB
