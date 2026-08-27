# Go live — one runbook

Everything is built and committed locally under your name (Nishank
&lt;Nishankde@gmail.com&gt;). These are the only steps left, and they run on your Mac.

## 1. One-time: log your machine into GitHub

Open **Terminal** and run:

```
gh --version
```

If it says "command not found":

```
brew install gh
gh auth login
```

Choose **GitHub.com → HTTPS → Login with a web browser** and follow the prompts.

## 2. Push everything — one command

```
cd ~/Desktop/30-Day-Projects-Challenge
./scripts/push-all.sh
```

This creates and pushes, in one go:

- all ten project repos (`url-shortener`, `applied-cryptography`, … `analytics-platform`)
- your **profile** repo (`nishankswamy`) — renders on your GitHub profile page
- the **index** repo (`30-days`) — the hub every link points to

Then confirm:

```
./scripts/status.sh
```

## 3. Put the portfolio site live (GitHub Pages)

In a browser:

1. Open your **`portfolio`** repo on github.com
2. **Settings → Pages** (left sidebar)
3. Branch: **`main`**, folder: **`/ (root)`** → **Save**
4. Wait ~1 minute, refresh. Your live URL appears:
   `https://nishankswamy.github.io/portfolio/`

`index.html` is already at the repo root, so root works — nothing to move.

## 4. Check it

- `github.com/nishankswamy` → your profile shows the challenge writeup
- `github.com/nishankswamy/30-days` → the index with all findings
- `nishankswamy.github.io/portfolio` → the live site

Put that Pages URL on your resume and LinkedIn.

---

**If a repo name comes out wrong** when `push-all.sh` runs, tell me the actual
name and I'll update every link to match.
