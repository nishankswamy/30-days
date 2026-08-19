# Status

_Last updated after Days 1–7._

Four days shipped, two projects complete. This file is the quick snapshot; each
project's own README has the depth, and `PROGRESS.md` tracks the day grid.

## What's built

| Days | Project | State | Tests | Repo |
|---|---|---|---|---|
| 1 | URL shortener with analytics | ✅ shipped | 66 | `url-shortener` |
| 2–4 | Applied cryptography | ✅ complete | 493 | `applied-cryptography` |
| 5–7 | Detection engineering | ✅ complete | 36 | `detection-engineering` |
| 8–10 | Columnar analytics engine | ⏭ next | — | — |

Everything after Day 7 is scoped in the folder READMEs but not started.

## The findings so far

The point of the challenge is the third-day writeup — the result that
contradicts what you assumed. Three of those are now on the board, and they're
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

## By the numbers

- **595 tests** across the three finished projects (66 + 493 + 36)
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

## Next

**Days 8–10 — columnar analytics engine.** A columnar storage format with
dictionary/RLE/bit-packing compression, a vectorised query engine, and zone maps
that skip whole chunks. Benchmarked against pandas and DuckDB on the same query.
The finding to chase: which query shape pandas wins, and by how much DuckDB beats
a hand-rolled engine.
