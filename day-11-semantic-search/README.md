# Day 11 — Semantic Search Engine

> **Week 2** · Real scale. 10k+ documents, measured quality.

## Stack
Python + embeddings + BM25 (rank_bm25 or Elasticsearch)

## Build this
- Index a real corpus: arXiv abstracts, HN posts, or a Wikipedia dump
- Hybrid BM25 + vector retrieval
- Reranking pass
- Search UI with latency displayed

## Stretch goals
- Measure recall@10 for vector vs keyword vs hybrid — chart it
- Sub-200ms p95 at 10k docs

## If you're running out of time
Smaller corpus, keep hybrid retrieval.

## Done when
Live search + quality benchmark

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
