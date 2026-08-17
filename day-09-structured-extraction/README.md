# Day 09 — Structured Extraction Service

> **Week 2** · Messy text in, validated JSON out. Boring and extremely employable.

## Stack
FastAPI + Pydantic + LLM

## Build this
- Schema-driven extraction (invoices, resumes, or emails — pick one)
- Pydantic validation on every output
- Retry loop when validation fails, with the error fed back to the model
- Batch endpoint

## Stretch goals
- Per-field confidence scores
- Fallback to a cheaper model first, escalate only on failure

## If you're running out of time
One document type, one schema.

## Done when
Deployed API + OpenAPI docs

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
