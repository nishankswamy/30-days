# Days 23-26 — CAPSTONE — Security Data Platform

> **Track:** capstone

Everything from the security track, assembled into one thing. This is the project you lead with.

## Concepts

- End-to-end ingestion
- Detection at scale
- Investigation workflow
- Analyst UX

## Build

**Day 23 — ingestion and storage.** Multi-source ingestion into your columnar store from Days 8-10. Retention policy, schema evolution, and a backfill path.

**Day 24 — detection.** Sigma rules from Days 5-7 plus the anomaly detectors from Days 11-13, running continuously with alert dedup and ATT&CK mapping.

**Day 25 — investigation.** The interface an analyst actually uses: alert triage queue, pivot from alert to raw events, timeline reconstruction, entity view (what else did this IP do?). This is where most security tools are bad and where yours can be good.

**Day 26 — prove it works.** Replay a full attack scenario end to end and produce the incident timeline your platform generated. Measure query latency at volume.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. How long from event ingestion to alert? Where is the bottleneck?
2. An analyst gets an alert. How many clicks to the raw evidence?
3. What does your platform do that Splunk doesn't, and honestly, what does Splunk do that you don't?

## Done when

Deployed platform + attack-replay walkthrough video

## If you're running out of time

Cut schema evolution and backfill before cutting the investigation UI.

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
