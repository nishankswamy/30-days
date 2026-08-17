# Days 8-10 — Columnar Analytics Engine

> **Track:** analytics

Everyone uses pandas. Far fewer can explain why an analytical query is 50x faster on columnar storage, and that explanation is the most portable thing in data engineering.

## Concepts

- Columnar vs row storage
- Dictionary encoding
- Run-length encoding
- Bit-packing
- Vectorised execution
- Predicate pushdown
- Late materialisation
- Zone maps / min-max indexes

## Build

**Day 8 — the storage layer.** Write a columnar file format: header, per-column chunks, compression per column type. Dictionary-encode low-cardinality strings, run-length encode sorted columns, bit-pack small integers. Measure the compression ratio against raw CSV for each encoding.

**Day 9 — vectorised execution.** A query engine operating on batches of ~1,024 values rather than row-at-a-time. Implement scan, filter, project, aggregate, group-by. Use numpy for the inner loops — the point is batch-at-a-time, not writing SIMD by hand.

**Day 10 — make it skip work.** Zone maps so a filter can skip entire chunks without decompressing. Predicate pushdown into the scan. Late materialisation so you only decode the columns and rows that survive the filter. Benchmark each optimisation separately against pandas and DuckDB on the same query.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. Your engine beats pandas on `SELECT country, SUM(revenue) ... WHERE year = 2024 GROUP BY country`. On which query shape does pandas win, and why?
2. Dictionary encoding made the file smaller. Did it make queries faster, slower, or both depending on the query?
3. Why does row-at-a-time execution lose so badly? Name the specific hardware reason.
4. DuckDB beats you. By how much, and which of its optimisations would you implement next?

## Done when

Query engine + a benchmark table isolating each optimisation

## If you're running out of time

Drop bit-packing and RLE, keep dictionary encoding and zone maps.

---

## Checklist

- [ ] Core built and working
- [ ] Tests covering the logic that matters
- [ ] Benchmark or evaluation with real numbers
- [ ] README: what it does, how it works, what the numbers say
- [ ] Depth questions answered in writing
- [ ] Committed and pushed

## Log

**Hours:**

**Hardest part:**

**What surprised me:**

**Interview story:**
