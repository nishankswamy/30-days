# Days 27-29 — CAPSTONE — Analytics Platform

> **Track:** capstone

The analytics equivalent. Pick a real public dataset with genuine size and mess to it.

## Concepts

- Real data at real scale
- Incremental processing
- Data quality
- Self-serve analytics

## Build

**Day 27 — ingest something real.** A public dataset large enough to be inconvenient: NYC taxi trips, GitHub Archive, Common Crawl index, or open government data. Incremental loading, not a one-shot script.

**Day 28 — quality and modelling.** Data quality checks that fail loudly (nulls, ranges, referential integrity, distribution drift). Dimensional model over the raw data. Incremental materialised aggregates.

**Day 29 — make it self-serve.** A query interface over your columnar engine, with cached aggregates and an honest cost/latency display. Document one finding from the data that would not be obvious without this work.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. What broke first when the data got big, and was it what you expected?
2. Which quality check caught something real?
3. What's the p95 query latency, and what would make it 10x better?

## Done when

Deployed platform + a written finding from the data

## If you're running out of time

Smaller dataset slice, keep the incremental loading.

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
