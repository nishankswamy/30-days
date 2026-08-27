# 30-Day Projects Challenge

**Security engineering and data analytics, at depth.**

> Current progress and the findings so far: [STATUS.md](STATUS.md).

Ten projects across 30 days, most spanning three days. Fewer, harder things
rather than thirty small ones — the projects that get someone hired are the ones
you can talk about for twenty minutes, and you can't do that with a weekend CRUD
app.

## The shape of it

| Days | Project | Track |
|---|---|---|
| 1 | [URL shortener with click analytics](day-01-url-shortener-analytics) | warm-up ✅ |
| 2–4 | [Applied cryptography and a secrets vault](day-02-04-applied-cryptography) | security |
| 5–7 | [Detection engineering pipeline](day-05-07-detection-engineering) | security + analytics |
| 8–10 | [Columnar analytics engine](day-08-10-columnar-query-engine) | analytics |
| 11–13 | [Anomaly detection on security telemetry](day-11-13-anomaly-detection) | security + analytics |
| 14–16 | [Network traffic analysis](day-14-16-network-traffic-analysis) | security |
| 17–19 | [Streaming pipeline with exactly-once semantics](day-17-19-streaming-pipeline) | analytics |
| 20–22 | [Privacy-preserving analytics](day-20-22-differential-privacy) | security + analytics |
| 23–26 | [CAPSTONE — Security data platform](day-23-26-siem-capstone) | capstone |
| 27–29 | [CAPSTONE — Analytics platform](day-27-29-analytics-capstone) | capstone |
| 30 | [Portfolio and writeup](day-30-portfolio) | capstone ✅ |

**All 30 days done.** The portfolio pulls it together: a deployable
[site](day-30-portfolio/src/index.html), the written
[case studies and findings](day-30-portfolio/src/PORTFOLIO.md), and
[resume bullets](day-30-portfolio/src/RESUME-BULLETS.md).

Everything is defensive: detection, analysis, hardening, cryptography, privacy.
Nothing here is offensive tooling, and the two places you attack something you
attack your own work — a timing side channel in your own HMAC, and
re-identification of a synthetic dataset you generated. That's how these
techniques are taught, and it's the half that's actually employable.

## Why three days per project

One day gets you a working thing. The third day is where you measure it, find
the result that contradicts what you assumed, and write that down. Day 1's
benchmark reported a 678x speedup that turned out to be timing a fallback path —
that finding is worth more than the feature it was measuring, and there was no
version of a one-day schedule that would have surfaced it.

Rough shape of each block:

1. **Day one** — build the core. It should work by the end of the day.
2. **Day two** — the hard half. The part you'd skip if you were rushing.
3. **Day three** — measure, break, tune, and write. No new features.

## Ground rules

1. **Every project produces a number.** A benchmark, a precision/recall table, a
   utility curve. "It works" is not a result.
2. **Report findings that embarrass you.** The statistical baseline beating your
   ML model is a better README than one that hides it.
3. **Answer the depth questions in writing.** Each project's README has them.
   They're what an interviewer would ask, and writing the answers is how you
   find the parts you only half know.
4. **Commit as you go**, with the *why* in the commit body.
5. **No secrets, no real customer data, no `.env` in git.** Generate synthetic
   data — every project here is designed so you can.

## Cut-scope rules when you're behind

| | Fallback |
|---|---|
| Scale | Smaller dataset. Never a smaller evaluation. |
| Breadth | Fewer detection rules, fewer encodings, fewer window types |
| Polish | Skip the UI, keep the CLI |
| **Never cut** | The measurement, the README, the depth answers |

Each project's README has its own specific cut rule at the bottom.

## Daily

```bash
./scripts/ship-day.sh 2                     # first push: creates the repo
./scripts/ship-day.sh 3 "Add the vault"     # later pushes
./scripts/status.sh                         # what's committed and pushed
```

Any day inside a range resolves to the right project — `2`, `3` and `4` all find
the cryptography folder. See [GIT.md](GIT.md).

## Prerequisites worth having ready

Python with numpy, pandas, scikit-learn, and cryptography. Docker for Kafka and
Postgres later on. `tshark` or scapy from Day 14. None of it needs installing
until the project that uses it.

## Archive

`archive/` holds the markdown notes app built on the original Day 2, before the
challenge was reweighted toward security and analytics. Its git history is
intact.
