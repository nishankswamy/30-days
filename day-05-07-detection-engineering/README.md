# Days 5-7 — Detection Engineering Pipeline

> **Track:** security + analytics

A detection that fires on everything is worse than no detection, because it trains people to ignore alerts. This project treats detection quality as a measurement problem, which is exactly how the job actually works.

## Concepts

- Log parsing and normalisation (ECS)
- Sigma rule evaluation
- Sliding-window aggregation
- Alert deduplication and grouping
- MITRE ATT&CK mapping
- Precision, recall, and alert fatigue
- Base rate fallacy

## Build

**Day 5 — ingestion and normalisation.** Parse real log formats (sshd auth logs, nginx access logs, Windows 4625 events) into a common schema. Use the Elastic Common Schema field names rather than inventing your own — matching an existing standard is the point.

**Day 6 — the rule engine.** Support a useful subset of Sigma: field matching, wildcards, `AND`/`OR`, and crucially aggregation over a time window (`count() by src_ip > 5 within 1m`). Rules load from YAML, not code. Map each to an ATT&CK technique id.

**Day 7 — measure the detections.** Generate a labelled dataset: mostly benign traffic with known-bad events injected. Compute precision and recall per rule. Tune the noisiest rule and show the tradeoff curve. Deduplicate alerts so one brute-force burst is one alert, not four hundred.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. Your rule has 95% precision. There are 10,000 benign events per attack. How many false positives does an analyst see per real detection, and is the rule usable?
2. Which of your rules would an attacker most easily evade, and what would evading it cost them?
3. Why does alert deduplication change precision but not recall?

## Done when

Pipeline + a precision/recall table per rule and a tuning writeup

## If you're running out of time

Two log formats instead of three. Keep the labelled evaluation — it's the whole project.

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
