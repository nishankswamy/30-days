# Git workflow

One repo per project. Each day's repo lives in `day-NN-*/src/` — that folder is
the repo root, so a clone gives someone `app/`, `tests/`, `README.md` at the top
level with no wrapper directory.

The challenge folder itself is a separate index repo tracking `README.md`,
`PROGRESS.md`, and the day specs. The `src/` folders are gitignored there so the
nested repos don't collide.

## Daily

```bash
cd ~/Desktop/30-Day-Projects-Challenge

./scripts/ship-day.sh 01                          # first push: creates the repo
./scripts/ship-day.sh 01 "Add Redis cache layer"  # later pushes
./scripts/status.sh                               # what's committed, dirty, pushed
```

`ship-day.sh` names the repo from the folder — `day-01-url-shortener` becomes
`url-shortener`. Set `REPO_VISIBILITY=private` if you'd rather not publish a
work-in-progress.

## One-time setup

```bash
brew install gh
gh auth login
```

## Commit habits worth keeping for 30 days

**Commit as you go, not once at the end.** Your contribution graph should show
the shape of the work. More importantly, a commit history that shows the
sequence of decisions is something you can walk an interviewer through.

**Write the why in the body.** The subject says what changed; the body says why
you chose it over the alternative. The Day 1 commit is the template:

```
Day 1: URL shortener with click analytics

Base62 codes derived from the row id, so collisions are impossible by
construction rather than handled with a retry loop. Redirects use 307
because browsers cache 301s and would silently stop recording clicks.
```

Six months from now that's the difference between remembering the tradeoff and
re-deriving it.

**Never commit `.env` or `*.db`.** Both are already in every `.gitignore` here.
If a secret does land in a commit, rotate the key — rewriting history is not
enough once it's pushed.

## When you're behind

Committing locally still counts. `ship-day.sh` will create the GitHub repo
whenever you get to it, and the commit dates stay honest.
