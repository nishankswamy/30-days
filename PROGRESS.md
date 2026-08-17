# Progress

| Days | Project | Shipped | Repo | Key number | Hardest part |
|---|---|---|---|---|---|
| 1 | URL shortener + analytics | ☑ | url-shortener | cache 1.1x, not 678x | Benchmark was timing the fallback path |
| 2–4 | Applied cryptography | ☐ | | | |
| 5–7 | Detection engineering | ☐ | | | |
| 8–10 | Columnar query engine | ☐ | | | |
| 11–13 | Anomaly detection | ☐ | | | |
| 14–16 | Network traffic analysis | ☐ | | | |
| 17–19 | Streaming pipeline | ☐ | | | |
| 20–22 | Differential privacy | ☐ | | | |
| 23–26 | CAPSTONE: security platform | ☐ | | | |
| 27–29 | CAPSTONE: analytics platform | ☐ | | | |
| 30 | Portfolio | ☐ | | | |

## Days

```
 1 ▓   2 ░   3 ░   4 ░   5 ░   6 ░   7 ░   8 ░   9 ░  10 ░
11 ░  12 ░  13 ░  14 ░  15 ░  16 ░  17 ░  18 ░  19 ░  20 ░
21 ░  22 ░  23 ░  24 ░  25 ░  26 ░  27 ░  28 ░  29 ░  30 ░
```

## Findings worth keeping

Things that turned out differently from what you assumed. This becomes the
Day 30 writeup, and most of your interview answers.

- **Day 1** — the Redis cache benchmark reported a 678x speedup. It was timing
  the cache's graceful-degradation path, which returns `None` in nanoseconds
  when Redis is unreachable. Real figure: 1.1x. A result that flatters the
  design is the one to distrust.

## Depth questions answered

Tick when the project README has written answers, not just working code.

- [ ] Days 2–4 — cryptography
- [ ] Days 5–7 — detection
- [ ] Days 8–10 — columnar
- [ ] Days 11–13 — anomaly detection
- [ ] Days 14–16 — traffic analysis
- [ ] Days 17–19 — streaming
- [ ] Days 20–22 — privacy
