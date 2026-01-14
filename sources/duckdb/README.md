# DuckDB Source

This folder defines the default DuckDB connection for Evidence.

Files:
- `connections.yaml` (primary): non-sensitive connection settings
- `connection.yaml` (compat): included for older Evidence versions
- `connection.options.yaml`: created by Evidence for secrets (if needed)

To use your own database:
1. Put your DuckDB file in this folder.
2. Update `filename` in `connections.yaml`.
3. Restart `evidence dev`.
