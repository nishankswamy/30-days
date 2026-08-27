# Status

_Last updated after Days 1–30 (all 10 projects built).__

All 30 days built, ten projects complete. Plus CI on every repo, and two projects deepened past their original scope. This file is the quick snapshot; each
project's own README has the depth, and `PROGRESS.md` tracks the day grid.

## What's built

| Days | Project | State | Tests | Repo |
|---|---|---|---|---|
| 1 | URL shortener with analytics | ✅ shipped | 66 | `url-shortener` |
| 2–4 | Applied cryptography | ✅ complete | 493 | `applied-cryptography` |
| 5–7 | Detection engineering | ✅ complete | 36 | `detection-engineering` |
| 8–10 | Columnar analytics engine | ✅ complete+ | 54 | `columnar-query-engine` |
| 11–13 | Anomaly detection on telemetry | ✅ complete | 21 | `anomaly-detection` |
| 14–16 | Network traffic analysis | ✅ complete+ | 48 | `network-traffic-analysis` |
| 17–19 | Streaming pipeline (exactly-once) | ✅ complete | 32 | `streaming-pipeline` |
| 20–22 | Privacy-preserving analytics | ✅ complete | 26 | `differential-privacy` |
| 23–26 | CAPSTONE — Security data platform | ✅ complete+ | 36 | `siem-capstone` |
| 27–29 | CAPSTONE — Analytics platform | ✅ complete | 19 | `analytics-platform` |
| 30 | Portfolio | ✅ shipped | — | `portfolio` |

All ten projects built, plus the Day 30 portfolio (deployable site, written case
studies, resume bullets). The challenge is complete.

## The findings so far

The point of the challenge is the third-day writeup — the result that
contradicts what you assumed. Ten of those are now on the board, and they're
the interview material:

**Day 1 — a benchmark that lied.** The Redis cache reported a 678x speedup. It
was timing the cache's graceful-degradation path, which returns `None` in
nanoseconds when Redis is unreachable. Real figure: 1.1x — an indexed SQLite
lookup costs about the same as a Redis round-trip. The benchmark now asserts a
real cache hit before timing anything. _A result that flatters the design is the
one to distrust._

**Day 2 — a MAC you can forge without the key.** `tag = SHA256(secret‖message)`
is the obvious way to authenticate a message and it's broken: a SHA-256 digest
*is* the hash's internal state, so anyone holding a tag can resume hashing and
append data. Forged `role=admin` onto a signed message in milliseconds; the only
unknown was the secret's length (~100 guesses). HMAC resists it at every length,
which is the reason its nested construction exists.

**Day 3 — the storage format beat the crypto.** Envelope encryption is supposed
to make password rotation flat in secret size, and the *crypto* is — 4.1 ms to
8.9 ms while the data grew 16,000x. But total rotation time hit 1.5 s, worse than
naive re-encryption, because the vault rewrites one JSON file containing every
ciphertext. The key hierarchy was right; the single-file storage defeated it.
That's exactly why real KMS systems keep ciphertexts as separate objects.

**Day 4 — a comparison that leaks its secret.** A byte-by-byte `==` returns on
the first mismatch, so its duration encodes how many leading bytes were right.
Recovered an 8-byte tag at 8.5σ; constant-time comparison leaked 0.2σ and the
attack collapsed to guessing. And one reused nonce gives `c1 XOR c2 = p1 XOR p2`
— the key cancels and both plaintexts fall out.

**Days 5–7 — a "low-noise" rule that sank the queue.** A detection labelled
informational fired on all 3,662 successful logins (one real) and dragged overall
precision to 0% while every real rule sat at 100%. Suppressing it from alerting
and feeding it to a correlation rule instead — successful login from an IP that
was just brute-forcing — took precision 0%→100% with recall unchanged. The
base-rate fallacy, measured: rare attacks make a common-event rule useless.

**Days 8–10 — "columnar is faster" is conditional, and Python has a ceiling.** At
2M rows in memory, pandas beat the hand-rolled engine on two of three queries —
columnar wins pay off against I/O and selectivity, not small in-memory scans. A
deep second pass added persistence, a streaming aggregate (10x→7.2x vs DuckDB
after profiling caught np.unique sorting strings), a hash join (30x→5x once the
unique-key probe was vectorised), and query compilation (1.75x on global
aggregates). Two honest negatives: thread parallelism is GIL-capped and
*regresses* past 2 workers; compilation only helps specific query shapes. Both
localise why DuckDB is 7x ahead — the GIL and native codegen.

**Days 11–13 — "use an ML model" is not a strategy.** On seasonal security
telemetry at a 1.7% base rate, the autoencoder narrowly beat the STL+MAD baseline
(AP 0.249 vs 0.206) — but only because it alone caught the purely multivariate
anomaly (normal marginals, broken login/request ratio) a univariate detector
can't see. Isolation Forest, the obvious ML pick, scored 0.057 — *worse* than the
simple baseline. ML earns its place for structure the baseline can't represent,
and is a liability applied reflexively.

**Days 14–16 — a beaconing detector that flags NTP is worse than useless.** C2
malware and NTP are identically periodic, so a timing-only detector caught all 8
beacons and all 35 legitimate periodic flows (19% precision). Dropping service
ports + requiring small consistent payloads recovered 100% — but a beacon tuned
to mimic HTTPS on 443 is invisible to network features alone and needs
destination reputation. All built from raw pcap bytes, no scapy.

**Days 17–19 — "exactly-once" is a phrase for a specific arrangement.** It doesn't
mean delivered-once (impossible over an unreliable channel); it means the effect
is applied once, via at-least-once delivery + an idempotent checkpointed sink. A
chaos test kills the pipeline mid-stream across 8 seeds and the counts match a
clean run every time. The boundary that matters: the guarantee ends at the sink's
state — an external side effect it triggers is still at-least-once unless made
idempotent too.

**Days 20–22 — anonymisation doesn't work, and the fix is a new definition.**
Dropping names re-identified 60% of a synthetic medical release by joining a voter
roll on (zip, birthdate, sex). k-anonymity stopped the linkage but leaked a whole
oncology cohort's cancer status via the homogeneity hole — it protects identity,
not the secret. Differential privacy is the actual answer; local DP measured 10-20x
noisier than central, and DP without a spent-down budget is theatre because
unbiased noise averages out.

**Days 23–26 (CAPSTONE) — the investigation layer is the product.** A working SIEM:
a full attack campaign buried in 2,300 benign events is ingested and detected
inline in 13ms (175k events/sec), all four stages caught. Firing alerts is the
easy 20%; alert → entity → full timeline is one indexed lookup each, 26x faster
than scanning. Upgraded since: a behavioural detector catches a signature-less
insider (139σ over its own baseline) that no rule would, and the timeline collapses
runs of identical events. Scoped honestly against Splunk.

**Days 27–29 (CAPSTONE) — what breaks at scale is memory, not compute.** An
analytics pipeline: incremental quality-gated ingestion, a dimensional model with
cubes, self-serve queries with a cost display. The fact table costs ~530 bytes/row
as Python dicts vs ~50 on disk — a 10x blow-up that's the real wall, and the fix is
the Days 8–10 columnar store (a clean callback). Cube-served queries stay flat at
0.19ms while uncovered scans grow to 330ms, so the uncovered query sets worst-case
latency. Quality gating fails loudly: error checks stop the load, warnings
quarantine and report, never silently drop.

## By the numbers

- **831 tests** across ten projects (66 + 493 + 36 + 54 + 21 + 48 + 32 + 26 + 36 + 19)
- **CI (GitHub Actions)** runs the suite on every push in all 10 repos
- **~1,400 lines** in the cryptography project alone, across primitives, a
  vault, and three attacks
- Every project ships with a benchmark or evaluation, not just "it works"

## Git

All work is committed locally, one repo per project plus this index repo. Remotes
are configured. To push the latest:

```bash
cd ~/Desktop/30-Day-Projects-Challenge
./scripts/ship-day.sh 1        # url-shortener
./scripts/ship-day.sh 2        # applied-cryptography (Days 2–4)
git push                       # this index repo
./scripts/status.sh            # confirm everything is pushed
```

If `gh` isn't set up yet: `brew install gh && gh auth login` once.

## Done

All 30 days shipped. The portfolio (Day 30) is the finish line — `day-30-portfolio/src/`
has the deployable site (`index.html`), the written case studies and findings
(`PORTFOLIO.md`), and role-split resume bullets (`RESUME-BULLETS.md`). Next step is
purely mechanical: push every repo with `./scripts/push-all.sh`.
