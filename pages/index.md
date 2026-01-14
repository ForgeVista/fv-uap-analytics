---
title: Analytics Home
---

Welcome to your Evidence dashboard for this project.

- Start the dev server with `evidence dev`
- Update your DuckDB file in `sources/duckdb/`
- See sample queries in the Examples section

```sql status
select
  'Dashboard ready' as item,
  'OK' as status
```

<DataTable data={status} />

Navigate to the sample page: [Examples](./examples/sample-query)
