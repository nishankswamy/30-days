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

# The index repo
cd "$ROOT"
if git remote get-url origin >/dev/null 2>&1; then
  git push -q origin HEAD 2>/dev/null && echo "✓ index repo — pushed" || echo "· index repo — up to date or needs -u"
fi

echo
echo "Done. Confirm with ./scripts/status.sh"
