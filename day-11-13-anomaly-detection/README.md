# Days 11-13 — Anomaly Detection on Security Telemetry

> **Track:** security + analytics

The hard part of anomaly detection is not finding anomalies. It's that at real base rates, a detector with excellent-sounding numbers produces an alert stream nobody can use.

## Concepts

- Seasonal decomposition (STL)
- EWMA and control charts
- Median absolute deviation
- Isolation Forest
- Precision/recall at realistic base rates
- Concept drift
- Threshold selection

## Build

**Day 11 — statistical baselines.** Login volume, bytes transferred, request rates. Handle seasonality properly — traffic has a daily and weekly shape, and a detector that flags every Monday morning is worthless. STL decomposition, then EWMA control limits and MAD-based thresholds on the residual.

**Day 12 — multivariate.** Isolation Forest and a simple autoencoder over feature vectors (bytes, duration, ports touched, hour-of-day). Compare against the statistical baselines on the same labelled data. The baseline usually wins on interpretable features, which is a finding worth reporting rather than hiding.

**Day 13 — the honesty pass.** Evaluate at a realistic base rate (1 attack per 100,000 events, not per 100). Plot precision-recall, not ROC — with class imbalance this severe, ROC curves flatter every model. Pick an operating threshold and defend it in terms of analyst hours.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. Your model has 99% accuracy. The attack rate is 0.001%. What does a model that predicts 'benign' always score, and what does that tell you about accuracy as a metric?
2. Why is precision-recall the right curve here and ROC the wrong one?
3. Your detector was tuned on last month's traffic. What happens in three months, and how would you know before an analyst tells you?
4. Did the ML model actually beat the statistical baseline? Report it either way.

## Done when

Detector + PR curves + a written threshold recommendation in analyst-hours

## If you're running out of time

Skip the autoencoder. Isolation Forest against a statistical baseline is enough.

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
