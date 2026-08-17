# Days 20-22 — Privacy-Preserving Analytics

> **Track:** security + analytics

Anonymisation mostly doesn't work, and the demonstrations of why are startling. Differential privacy is the actual answer, and very few engineers can implement it correctly — which is exactly why it's worth three days.

## Concepts

- k-anonymity and its failure modes
- Re-identification via quasi-identifiers
- Laplace and Gaussian mechanisms
- Privacy budget (epsilon) and composition
- Local vs central DP
- Randomised response
- Utility/privacy tradeoff curves

## Build

**Day 20 — show that anonymisation fails.** Generate a synthetic dataset with realistic quasi-identifiers (postcode, birth date, sex). Apply k-anonymity. Then re-identify individuals by joining against a second synthetic 'public' dataset. This reproduces the Sweeney result on data you created, which is the safe and honest way to demonstrate it.

**Day 21 — implement DP properly.** Laplace and Gaussian mechanisms for counts, sums and means. Sensitivity analysis for each query type — getting sensitivity wrong is the most common way DP implementations are silently broken. Track a privacy budget across queries and refuse to answer once it's spent.

**Day 22 — what does privacy cost?** Plot utility against epsilon for each query type. Implement randomised response for local DP and compare its noise to the central model. Write the recommendation an actual data team would need: which epsilon, and what it means in plain language.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. What does epsilon = 1 actually promise a person in the dataset? Say it without using the word 'privacy'.
2. You answered 100 queries at epsilon 0.1 each. What's your real total privacy loss, and why isn't it simply 10?
3. Why is local DP so much noisier than central DP, and when is that cost worth paying?
4. Your k-anonymised dataset was re-identified with what fraction of records? What does that suggest about published 'anonymised' datasets?

## Done when

DP library + re-identification demo + utility/privacy curves

## If you're running out of time

Laplace mechanism only, skip Gaussian and local DP.

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
