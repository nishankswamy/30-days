# Days 14-16 — Network Traffic Analysis

> **Track:** security

Defensive traffic analysis: reconstruct what happened on a network from packets alone. Every technique here is about observing your own network, which is what a blue team does all day.

## Concepts

- pcap parsing
- Flow reconstruction
- TLS fingerprinting (JA3/JA4)
- DNS tunnelling detection
- Entropy analysis
- Beaconing detection
- Encrypted traffic inference

## Build

**Day 14 — parse packets properly.** Read pcap yourself: Ethernet, IPv4/IPv6, TCP/UDP headers. Reassemble bidirectional flows with correct handling of out-of-order segments and retransmissions. Emit flow records (5-tuple, duration, bytes, packet counts).

**Day 15 — fingerprinting and DNS.** Extract TLS ClientHello fields and compute JA3/JA4 hashes to identify client software without decrypting anything. Then detect DNS tunnelling: query-length distribution, subdomain entropy, query rate per domain, and NXDOMAIN ratio.

**Day 16 — beaconing.** Find command-and-control-style periodic callbacks in flow data using inter-arrival time regularity and jitter tolerance. Test against traffic you generate yourself with a known beacon interval, plus normal traffic that is also periodic (NTP, software update checks) to see your false positive rate.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. JA3 identifies client software without decryption. What does that imply for privacy, and why did JA4 replace it?
2. Your beaconing detector flags NTP and update checkers. How would you separate 'periodic' from 'suspicious' without an allowlist?
3. Entropy flags DNS tunnelling. What legitimate traffic also has high-entropy subdomains, and how many false positives does that cost you?
4. What can you infer about an encrypted session from packet sizes and timings alone?

## Done when

Analyser + detection writeup with measured false positive rates

## If you're running out of time

Use dpkt or scapy for parsing rather than writing it by hand; keep the detection logic yours.

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
