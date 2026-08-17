# Days 2-4 — Applied Cryptography and a Secrets Vault

> **Track:** security

Almost everyone can call a crypto library. Very few can say why the library refuses to let you do the obvious thing. This project is about that gap.

## Concepts

- SHA-256 and HMAC from the spec
- PBKDF2 / Argon2id key derivation
- AEAD (AES-GCM, XChaCha20-Poly1305)
- Envelope encryption and key rotation
- Constant-time comparison
- Timing side channels
- Nonce reuse catastrophe

## Build

**Day 2 — primitives from the spec.** Implement SHA-256 and HMAC-SHA256 yourself, against the RFC test vectors. Then implement PBKDF2 on top of your HMAC. This is the only part you write from scratch; everything after uses a real library, which is the actual lesson.

**Day 3 — the vault.** A CLI secrets manager: master password -> Argon2id -> key encryption key -> per-secret data keys (envelope encryption). AEAD for every secret, with the secret's id as associated data so a ciphertext can't be moved between records. Key rotation that re-wraps data keys without re-encrypting every secret.

**Day 4 — break your own work.** Write a timing attack against a naive `==` comparison of your HMAC, and show it succeeding. Then switch to constant-time comparison and show it failing. Demonstrate what nonce reuse does to AES-GCM by recovering the XOR of two plaintexts from two ciphertexts sharing a nonce.

## Depth questions

Answer these in the README when you're done. They're what an interviewer would
ask, and writing the answers down is how you find the parts you only half know.

1. Why is Argon2id preferred over PBKDF2 for password hashing, and what specifically does it defend against that PBKDF2 doesn't?
2. Why does envelope encryption make key rotation cheap? What would rotation cost without it?
3. What does AEAD's 'associated data' actually protect, and what attack does it stop?
4. Your timing attack needed how many samples? What does that tell you about whether the vulnerability was practically exploitable over a network?

## Done when

CLI vault + a writeup with the timing-attack measurements and graphs

## If you're running out of time

Skip Argon2id, use PBKDF2 with a high iteration count. Never skip the constant-time comparison.

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
