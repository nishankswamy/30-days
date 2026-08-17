#!/usr/bin/env bash
# Commit a project and push it to its own GitHub repo.
#
#   ./scripts/ship-day.sh 2
#   ./scripts/ship-day.sh 3 "Add the vault CLI"
#
# Projects span several days, so any day inside a range resolves to the same
# folder: 2, 3 and 4 all find day-02-04-applied-cryptography.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DAY="${1:?usage: ship-day.sh <day-number> [commit message]}"
MESSAGE="${2:-}"

VISIBILITY="${REPO_VISIBILITY:-public}"
GIT_NAME="${GIT_NAME:-Sharath}"
GIT_EMAIL="${GIT_EMAIL:-sharath.surya176@gmail.com}"

# --- resolve the day to a folder -------------------------------------------
# Folder names are day-NN-slug or day-NN-MM-slug. Strip leading zeroes with
# 10# so 08 isn't read as invalid octal.
WANTED=$((10#$(echo "$DAY" | tr -cd '0-9')))
FOLDER=""

for candidate in "$ROOT"/day-*/; do
  name=$(basename "$candidate")
  numbers=$(echo "$name" | grep -oE '^day-[0-9]+(-[0-9]+)?' | sed 's/^day-//')
  start=$((10#${numbers%%-*}))
  end=$((10#${numbers##*-}))
  if [ "$WANTED" -ge "$start" ] && [ "$WANTED" -le "$end" ]; then
    FOLDER="${candidate%/}"
    break
  fi
done

if [ -z "$FOLDER" ]; then
  echo "✗ No project covering day $WANTED in $ROOT" >&2
  exit 1
fi

PROJECT="$FOLDER/src"
[ -d "$PROJECT" ] || { echo "✗ No src/ in $(basename "$FOLDER")." >&2; exit 1; }

# Repo name: day-02-04-applied-cryptography -> applied-cryptography
REPO_NAME=$(basename "$FOLDER" | sed -E 's/^day-[0-9]+(-[0-9]+)?-//')
LABEL=$(basename "$FOLDER" | grep -oE '^day-[0-9]+(-[0-9]+)?' | sed 's/^day-//')

cd "$PROJECT"

if [ ! -d .git ]; then
  REAL=$(find . -type f ! -name '.gitkeep' ! -path './.git/*' | head -1)
  [ -n "$REAL" ] || { echo "✗ $(basename "$FOLDER")/src is empty — build something first." >&2; exit 1; }
  echo "→ initialising repo"
  git init -q -b main
  git config user.name "$GIT_NAME"
  git config user.email "$GIT_EMAIL"
fi

git add -A
if git diff --cached --quiet; then
  echo "→ nothing new to commit"
else
  if [ -z "$MESSAGE" ]; then
    if git rev-parse HEAD >/dev/null 2>&1; then
      MESSAGE="Days ${LABEL}: progress"
    else
      MESSAGE="Days ${LABEL}: ${REPO_NAME//-/ }"
    fi
  fi
  git commit -q -m "$MESSAGE"
  echo "→ committed: $MESSAGE"
fi

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
echo "✓ Days ${LABEL} shipped → $URL"
echo "  Add the link to PROGRESS.md and tick the box."
