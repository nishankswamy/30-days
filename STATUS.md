# Status

_Last updated after Days 1–4._

Four days shipped, two projects complete. This file is the quick snapshot; each
project's own README has the depth, and `PROGRESS.md` tracks the day grid.

## What's built

| Days | Project | State | Tests | Repo |
|---|---|---|---|---|
| 1 | URL shortener with analytics | ✅ shipped | 66 | `url-shortener` |
| 2–4 | Applied cryptography | ✅ complete | 493 | `applied-cryptography` |
| 5–7 | Detection engineering | ⏭ next | — | — |

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

## By the numbers

- **559 tests** across the two finished projects (66 + 493)
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

**Days 5–7 — detection engineering pipeline.** Parse real log formats into a
common schema, build a Sigma rule engine with time-window aggregation, and — the
actual point — measure detection quality with precision and recall on a labelled
dataset. The finding to chase: what a 95%-precision rule does to an analyst when
there are 10,000 benign events per attack.
