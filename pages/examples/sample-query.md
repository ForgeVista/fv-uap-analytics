---
title: Sample Queries
queries:
  - sample: sample.sql
---

This page demonstrates a reusable file query and a simple chart.

<BarChart data={sample} x=label y=value title="Example Chart" />

```sql inline_example
select
  'Inline query' as label,
  42 as value
```

<DataTable data={inline_example} />
