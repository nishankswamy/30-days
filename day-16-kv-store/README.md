# Day 16 — Key-Value Store With Persistence

> **Week 3** · Redis-protocol compatible, so `redis-cli` connects to your own database.

## Stack
Any systems language

## Build this
- In-memory hashmap + append-only log
- Log compaction
- RESP protocol so redis-cli works against it
- GET / SET / DEL / EXPIRE

## Stretch goals
- Snapshotting + crash recovery, with a test that kills the process mid-write
- Simple LRU eviction under a memory cap

## If you're running out of time
Skip compaction, keep persistence.

## Done when
GIF of redis-cli talking to your server

---

## Checklist
- [ ] Core features working
- [ ] Deployed / installable
- [ ] README written (what · demo GIF · why · architecture · what I'd change)
- [ ] Demo GIF or screenshot recorded
- [ ] Pushed to its own repo
- [ ] Logged in `PROGRESS.md` at the root

## Log

**Hours spent:**

**Hardest bug:**

**What I'd do differently:**

**Interview story from today:**
