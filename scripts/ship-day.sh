#!/usr/bin/env bash
# Commit a day's project and push it to its own GitHub repo.
#
#   ./scripts/ship-day.sh 01
#   ./scripts/ship-day.sh 01 "Add Redis cache on hot links"
#
# First run for a day: creates the repo on GitHub and pushes.
# Later runs: commits and pushes to the existing repo.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DAY="${1:?usage: ship-day.sh <day-number> [commit message]}"
MESSAGE="${2:-}"

VISIBILITY="${REPO_VISIBILITY:-public}"
GIT_NAME="${GIT_NAME:-Sharath}"
GIT_EMAIL="${GIT_EMAIL:-sharath.surya176@gmail.com}"

# --- locate the day folder -------------------------------------------------
DAY_PADDED=$(printf "%02d" "$(echo "$DAY" | sed 's/[^0-9].*//')" 2>/dev/null || echo "$DAY")
FOLDER=$(find "$ROOT" -maxdepth 1 -type d -name "day-${DAY_PADDED}*" | head -1)

if [ -z "$FOLDER" ]; then
  echo "✗ No folder matching day-${DAY_PADDED}* in $ROOT" >&2
  exit 1
fi

PROJECT="$FOLDER/src"
[ -d "$PROJECT" ] || { echo "✗ No src/ folder in $FOLDER — nothing to ship." >&2; exit 1; }

# Repo name: day-01-url-shortener -> url-shortener
REPO_NAME=$(basename "$FOLDER" | sed 's/^day-[0-9-]*//')
DAY_LABEL=$(basename "$FOLDER" | grep -o '^day-[0-9]*' | sed 's/day-//')

cd "$PROJECT"

# --- init if this is the first push ---------------------------------------
if [ ! -d .git ]; then
  echo "→ initialising repo"
  git init -q -b main
  git config user.name "$GIT_NAME"
  git config user.email "$GIT_EMAIL"
fi

# --- commit ----------------------------------------------------------------
git add -A
if git diff --cached --quiet; then
  echo "→ nothing new to commit"
else
  if [ -z "$MESSAGE" ]; then
    if git rev-parse HEAD >/dev/null 2>&1; then
      MESSAGE="Day ${DAY_LABEL}: progress"
    else
      MESSAGE="Day ${DAY_LABEL}: ${REPO_NAME//-/ }"
    fi
  fi
  git commit -q -m "$MESSAGE"
  echo "→ committed: $MESSAGE"
fi

# --- push ------------------------------------------------------------------
command -v gh >/dev/null 2>&1 || {
  echo "✗ gh CLI not found. Install it:  brew install gh && gh auth login" >&2
  exit 1
}

if git remote get-url origin >/dev/null 2>&1; then
  git push -q origin main
  echo "→ pushed to $(git remote get-url origin)"
else
  echo "→ creating GitHub repo: $REPO_NAME ($VISIBILITY)"
  gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push
fi

URL=$(gh repo view --json url -q .url 2>/dev/null || git remote get-url origin)
echo
echo "✓ Day ${DAY_LABEL} shipped → $URL"
echo "  Add the link to PROGRESS.md and tick the box."
