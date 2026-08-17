# Day 02 — Markdown Notes App with Full-Text Search

> **Week 1** · Client-side state done well. Keyboard-first UX.

## Stack
React + IndexedDB (or SQLite FTS5 if you go server-side)

## Build this
- Live markdown preview, split pane
- Tag system with filter
- Full-text search across all notes
- Keyboard shortcuts for everything (new, search, save, toggle preview)

## Stretch goals
- Write your own fuzzy-match ranking instead of using a library
- Export whole vault as a zip of .md files

## If you're running out of time
Drop tags, keep search.

## Done when
Deployed app + demo GIF

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

## Day 2 outcome

**Shipped:** working app, 87 tests, benchmark, sample content.

**Core done:**
- [x] Live markdown preview, split pane
- [x] Tag system with filter
- [x] Full-text search across all notes
- [x] Keyboard shortcuts for everything

**Stretch done:**
- [x] Own ranking rather than a library — BM25, benchmarked against substring
- [x] Export the vault as a zip — hand-rolled writer, no dependency

**Still to do:** record the demo GIF (see `src/docs/DEMO.md`), deploy the static
build, fill in "What I'd do differently".

**The interview story:** substring search and BM25 both "work". The benchmark
made the difference concrete — querying `kafka` over 5,000 notes, substring
filtering returned three notes about Kubernetes, Redis and Rust, because all it
can answer is whether the word appears. Ranking is the feature; matching is the
easy part.
