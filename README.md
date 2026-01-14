# ForgeVista UAP Analytics

This is a **template** for project analytics using **DuckDB + Evidence.dev**. It is designed for consultants and analysts who want a clean starting point for dashboards.

## Prerequisites (install once)

- Git
- Node.js **16+** (includes npm)
- DuckDB CLI
- Internet connection (for first-time installs)

If you are on **Windows**, use **WSL** (Windows Subsystem for Linux).

## Quick Start (3 steps)

1) **Create a new repo from this template** in GitHub.
2) Open a terminal in your new repo.
3) Run:

```bash
./bootstrap.sh
```

Then start Evidence:

```bash
evidence dev
```

Evidence will print a local URL (usually http://localhost:3000). Open it in your browser.

## Connect Your DuckDB Data

1) Put your `.duckdb` file in `sources/duckdb/`
2) Update the filename in `sources/duckdb/connections.yaml`

Example file path:

```
sources/duckdb/analytics.duckdb
```

If you need to create a DuckDB file from a CSV, you can use:

```bash
duckdb sources/duckdb/analytics.duckdb
```

Then in the DuckDB prompt:

```sql
CREATE TABLE example AS SELECT * FROM read_csv_auto('data/example.csv');
```

## Build Your First Dashboard

- Start with `pages/index.md`
- See sample usage in `pages/examples/sample-query.md`
- Reusable SQL lives in `queries/`

## Troubleshooting

**"evidence: command not found"**
- Run `./bootstrap.sh` again
- Then restart your terminal

**"node: command not found" or Node < 16**
- Install Node.js 16+ from https://nodejs.org/en/download

**DuckDB not found**
- Install via https://duckdb.org/docs/installation/cli

**Port already in use**
- Stop the other process or run:
  ```bash
  EVIDENCE_PORT=3001 evidence dev
  ```

**Permission errors with npm**
- Use a Node version manager (nvm) or reinstall Node from nodejs.org

## What Happens After Bootstrap

- Installs missing tools (Git, Node.js, DuckDB CLI, Evidence.dev)
- Verifies versions and prints results
- Safe to run multiple times

---

Need help? Check the `pages/` folder for examples, or ask your technical lead.
