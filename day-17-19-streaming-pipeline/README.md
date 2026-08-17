# Days 17-19 — Streaming Pipeline with Exactly-Once Semantics

> **Track:** analytics

'Exactly-once' is a marketing phrase for a specific engineering arrangement. Being able to say precisely what it does and doesn't guarantee is a strong signal in a data engineering interview.

## Concepts

- Event time vs processing time
- Watermarks
- Windowing (tumbling, sliding, session)
- Late and out-of-order data
- Idempotent sinks
- Checkpointing
- Backpressure
- At-least-once vs effectively-once

## Build

**Day 17 — the log.** An append-only partitioned log with consumer offsets — the Kafka model, small. Producers, consumers, consumer groups, and offset commits. Deliberately make it at-least-once first, and demonstrate duplicates appearing after a consumer crash.

**Day 18 — windowing on event time.** Tumbling and sliding windows keyed by event time, not arrival time. Watermarks to decide when a window can close. A late-data policy: how late is too late, and where do stragglers go? Show a window producing the wrong answer without watermarks, then the right one with them.

**Day 19 — make duplicates stop mattering.** Idempotent sink keyed on (partition, offset). Checkpoint state so a restart resumes rather than replays into double-counting. Then kill the process mid-window repeatedly and prove the output is stable. Add backpressure so a slow consumer doesn't grow the queue without bound.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. You have 'exactly-once'. Where exactly does the guarantee end — is it end-to-end, or between two specific points?
2. A message arrives 6 hours late. What does your pipeline do, and what would Flink do?
3. Why can't you just deduplicate by message id and call it a day?
4. Under backpressure, do you drop, buffer, or block? Which did you choose and what breaks when you're wrong?

## Done when

Pipeline + a chaos test showing stable output across repeated kills

## If you're running out of time

Tumbling windows only, skip session windows.

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
