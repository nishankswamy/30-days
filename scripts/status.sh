#!/usr/bin/env bash
# Show git state for every day folder at a glance.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

printf "%-28s %-8s %-7s %s\n" "DAY" "COMMITS" "DIRTY" "REMOTE"
printf "%-28s %-8s %-7s %s\n" "---" "-------" "-----" "------"

for folder in "$ROOT"/day-*/; do
  name=$(basename "$folder")
  project="$folder/src"

  if [ ! -d "$project/.git" ]; then
    printf "%-28s %-8s %-7s %s\n" "$name" "-" "-" "not started"
    continue
  fi

  commits=$(git -C "$project" rev-list --count HEAD 2>/dev/null || echo 0)
  dirty=$([ -n "$(git -C "$project" status --porcelain)" ] && echo "yes" || echo "no")
  remote=$(git -C "$project" remote get-url origin 2>/dev/null || echo "local only")
  printf "%-28s %-8s %-7s %s\n" "$name" "$commits" "$dirty" "$remote"
done
