# Day 01 — URL Shortener with Analytics

> **Week 1** · Rebuild the deploy muscle. First live URL of the challenge.

## Stack
FastAPI or Express + Postgres

## Build this
- Base62 short-code generation (write the encoder yourself)
- Redirect endpoint with click tracking
- Analytics page: clicks over time, referrer breakdown, top links
- Custom alias support + collision handling

## Stretch goals
- Redis cache layer on hot links, measure the latency delta
- QR code generation per link

## If you're running out of time
Skip the analytics charts, keep raw counts.

## Done when
Deployed URL + README

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

---

## Day 1 outcome

**Shipped:** working app, 34 tests, two benchmarks, seed data, QR codes.

**Stretch goals done:**
- [x] Unguessable codes via a bijection over the code space
- [x] Redis cache on hot links, with the latency delta measured
- [x] QR code per link
- [ ] Alembic migrations — left as a known gap

**Still to do:** record the demo GIF (see `src/docs/DEMO.md`), push to GitHub,
fill in "What I'd do differently" in `src/README.md`.

**The interview story:** the first benchmark reported a 678x speedup from the
Redis cache. It was measuring the cache's own graceful-degradation path — when
Redis is unreachable, `get_link` returns `None` in nanoseconds. The benchmark now
asserts a real cache hit before timing anything, and the honest number is 1.1x.
The lesson is that a result which flatters your design is the one to distrust.
