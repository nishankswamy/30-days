# Progress

| Days | Project | Shipped | Repo | Key number | Hardest part |
|---|---|---|---|---|---|
| 1 | URL shortener + analytics | ☑ | url-shortener | cache 1.1x, not 678x | Benchmark was timing the fallback path |
| 2–4 | Applied cryptography | ☑ done | applied-cryptography | timing leak 8.5σ vs 0.2σ; nonce reuse recovers both plaintexts | Interleaving to pull signal from timing noise |
| 5–7 | Detection engineering | ☑ done | detection-engineering | tuning: 0%→100% precision, recall unchanged | One 'low-noise' rule sinking the whole queue |
| 8–10 | Columnar query engine | ☑ done+ | columnar-query-engine | deep pass: streaming agg 10x→7.2x, join 30x→5x, GIL-capped parallelism | np.unique sorting strings; the GIL killing thread parallelism |
| 11–13 | Anomaly detection | ☑ done | anomaly-detection | autoencoder AP 0.249 > baseline 0.206; Isolation Forest 0.057 (worse) | Making a fair test of the multivariate/sustained cases |
| 14–16 | Network traffic analysis | ☑ done | network-traffic-analysis | beaconing: 19%→100% precision after dropping NTP; timing can't catch a 443-mimicking beacon | Canonicalising the 5-tuple direction |
| 17–19 | Streaming pipeline | ☑ done | streaming-pipeline | chaos test: 8 seeds, crash-and-recover output identical to clean run | Where exactly-once actually ends (the sink boundary) |
| 20–22 | Differential privacy | ☑ done | differential-privacy | 60% re-identified; k-anon leaks a cohort's cancer; DP local 10-20x noisier than central | The randomised-response calibration trap (2e^ε+1 vs e^ε) |
| 23–26 | CAPSTONE: security platform | ☑ done | siem-platform | full attack replay: 4/4 stages caught, 175k events/s, pivot 26x faster than scan | Keeping investigation entity-first, not query-first |
| 27–29 | CAPSTONE: analytics platform | ☐ | | | |
| 30 | Portfolio | ☐ | | | |

## Days

```
 1 ▓   2 ▓   3 ▓   4 ▓   5 ▓   6 ▓   7 ▓   8 ░   9 ░  10 ░
11 ░  12 ░  13 ░  14 ▓  15 ▓  16 ▓  17 ▓  18 ▓  19 ▓  20 ░
21 ░  22 ░  23 ▓  24 ▓  25 ▓  26 ▓  27 ▓  28 ▓  29 ▓  30 ░
```

## Findings worth keeping

Things that turned out differently from what you assumed. This becomes the
Day 30 writeup, and most of your interview answers.

- **Days 23–26 (CAPSTONE)** — a working SIEM assembling the security track. A
  full attack campaign (recon → brute force → landed login → exfil) buried in
  2,300 benign events is ingested and detected inline in 13ms (175k events/sec,
  p99 13.6µs), all four stages caught. The finding: firing alerts is the easy
  20%; the investigation layer is the 80% most tools skip. Alert → entity → full
  timeline is one indexed lookup each, 26x faster than scanning, because the
  store keeps inverted entity indexes. Scoped honestly against Splunk: the
  correct architecture at a size you can hold in your head, not a feature match.

- **Days 20–22** — anonymisation as usually practised doesn't work. Dropping
  names re-identified 60% of a synthetic medical release via a voter-roll join
  (Sweeney's attack). k-anonymity stopped the linkage but leaked a whole
  oncology cohort's cancer status through the homogeneity hole — it protects
  identity, not the secret. Differential privacy is the actual fix, and the
  costs are measured: local DP is 10-20x noisier than central at equal epsilon,
  and DP without a spent-down budget is theatre because unbiased noise averages
  out. Caught a calibration trap: the truth-or-uniform randomised response gives
  ratio 2e^ε+1, not e^ε — silently weaker privacy.

- **Days 17–19** — "exactly-once" is a phrase for a specific arrangement, not a
  delivery guarantee. Built at-least-once first so the duplicate is visible
  (crash before offset commit replays the batch), then made effectively-once
  with an idempotent sink keyed on (partition, offset) plus atomic checkpoints.
  A chaos test kills the pipeline mid-stream across 8 seeds and the final counts
  match a clean run every time. The boundary that matters: the guarantee holds
  to the sink's state, not to an external side effect (an email) unless that's
  idempotent too. Also: watermarks catch a straggler (count 4) that a tight
  watermark drops (count 3).

- **Days 14–16** — a beaconing detector that flags NTP is worse than useless.
  Timing alone (coefficient of variation) caught all 8 C2 beacons but also all
  35 legitimate periodic flows — 19% precision — because NTP and update checks
  are as periodic as any malware. Dropping service ports and requiring small
  consistent payloads recovered 100% precision, but a beacon tuned to mimic
  HTTPS on 443 stays invisible to network features alone: it needs destination
  reputation. Also: JA3 is order-sensitive so Chrome's extension randomisation
  broke it; JA4 sorts first and survives — both implemented to make it concrete.

- **Days 11–13** — "use an ML model" is not a strategy. On seasonal security
  telemetry at a 1.7% base rate: the autoencoder narrowly beat the STL+MAD
  baseline (AP 0.249 vs 0.206), but *only* because it alone caught the purely
  multivariate anomaly (normal marginals, broken login/request ratio) that a
  univariate detector is structurally blind to. Isolation Forest — the obvious
  ML pick — scored 0.057, worse than the simple baseline. And no point detector
  caught the sustained low-and-slow shift. ML earns its place for structure the
  baseline can't represent, and is a liability applied reflexively.

- **Days 8–10** — everyone knows columnar is "faster", but at 2M rows in RAM
  pandas beat the hand-rolled engine on two of three queries. Columnar wins pay
  off against I/O and selectivity, not small in-memory scans. Zone maps were
  the real optimisation (1.8x, skipping 235/245 chunks on a selective filter);
  DuckDB was 10x ahead on the full-table aggregate, which localises the next
  thing to build (parallel vectorised hash aggregation). Also caught a silent
  bug: dictionary encoding stringified integers, so an int column round-tripped
  to strings.

- **Days 5–7** — a rule labelled "informational, low-noise" in its own file
  was the single worst thing in the alert queue: it fired on all 3,662
  successful logins (one real) and sank overall precision to 0% while every
  threshold rule sat at 100%. Suppressing it from alerting and feeding it into
  a correlation rule instead took precision 0%→100% with recall unchanged at
  100%. The base-rate fallacy made concrete: when attacks are 0.76% of events,
  a rule on common events is useless however low-noise it looks alone.

- **Day 4** — a byte-by-byte comparison leaks its secret through timing: the
  early return encodes how many leading bytes matched. Recovered an 8-byte tag
  at 8.5σ confidence; constant-time comparison leaked 0.2σ and the attack
  became blind guessing. Separately, reusing a nonce once gives `c1 XOR c2 =
  p1 XOR p2` — the key cancels and both plaintexts fall out. Neither is subtle
  once you see it; both are one line of code to get wrong.

- **Day 3** — envelope encryption is supposed to make key rotation flat in
  secret size, and the *crypto* is: 4.1 ms to 8.9 ms while the data grows
  16,000x. Total rotation time still hit 1.5 s, worse than naive re-encryption,
  because the vault rewrites one JSON file containing every ciphertext. The key
  hierarchy was right and the storage format defeated it — which is why real
  KMS systems keep ciphertexts as separate objects.

- **Day 2** — `tag = SHA256(secret || message)` is forgeable without the
  secret, because a digest *is* the hash's internal state. Forged `role=admin`
  onto a signed message in milliseconds; the only unknown was the secret's
  length, which is ~100 guesses. HMAC resists it at every length. That's the
  reason the nested construction exists.

- **Day 1** — the Redis cache benchmark reported a 678x speedup. It was timing
  the cache's graceful-degradation path, which returns `None` in nanoseconds
  when Redis is unreachable. Real figure: 1.1x. A result that flatters the
  design is the one to distrust.

## Depth questions answered

Tick when the project README has written answers, not just working code.

- [x] Days 2–4 — cryptography
- [x] Days 5–7 — detection
- [x] Days 8–10 — columnar
- [x] Days 11–13 — anomaly detection
- [ ] Days 14–16 — traffic analysis
- [ ] Days 17–19 — streaming
- [ ] Days 20–22 — privacy
