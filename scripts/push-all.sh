#!/usr/bin/env bash
# Push every started project to its GitHub repo, then the index repo.
# Idempotent: repos with nothing new just report "nothing to push".
#
#   ./scripts/push-all.sh
#
# Needs gh authenticated (brew install gh && gh auth login).

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

command -v gh >/dev/null 2>&1 || {
  echo "✗ gh CLI not found. Install: brew install gh && gh auth login" >&2
  exit 1
}

for folder in "$ROOT"/day-*/; do
  project="$folder/src"
  [ -d "$project/.git" ] || continue
  name=$(basename "$folder")
  cd "$project"

  if git remote get-url origin >/dev/null 2>&1; then
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "?")
    if [ "$ahead" = "0" ]; then
      echo "· $name — up to date"
    else
      git push -q origin HEAD && echo "✓ $name — pushed"
    fi
  else
    repo=$(echo "$name" | sed -E 's/^day-[0-9]+(-[0-9]+)?-//')
    echo "→ $name — creating repo '$repo'"
    gh repo create "$repo" --public --source=. --remote=origin --push
  fi
done

# The profile-page repo (renders on github.com/nishankswamy)
profile="$ROOT/profile-readme"
if [ -d "$profile" ]; then
  cd "$profile"
  [ -d .git ] || { git init -q && git add -A && git commit -q -m "Profile README"; }
  if git remote get-url origin >/dev/null 2>&1; then
    git push -q origin HEAD && echo "✓ profile repo (nishankswamy) — pushed"
  else
    echo "→ profile — creating repo 'nishankswamy'"
    gh repo create nishankswamy --public --source=. --remote=origin --push
  fi
fi

# The index repo (renders as github.com/nishankswamy/30-days)
cd "$ROOT"
if git remote get-url origin >/dev/null 2>&1; then
  git push -q origin HEAD 2>/dev/null && echo "✓ index repo (30-days) — pushed" || echo "· index repo — up to date"
else
  echo "→ index — creating repo '30-days'"
  gh repo create 30-days --public --source=. --remote=origin --push
fi

echo
echo "Done. Confirm with ./scripts/status.sh"
echo "Next: enable GitHub Pages on the 'portfolio' repo (Settings → Pages → main / root)."
