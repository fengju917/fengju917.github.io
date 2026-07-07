#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/Users/juju/fengju917.github.io"
FILE="101.html"
BRANCH="main"

cd "$REPO_DIR"

# Keep local branch up to date before committing this file.
git pull --rebase --autostash origin "$BRANCH"

# Only sync 101.html. Ignore any other local files or scripts.
if git diff --quiet -- "$FILE"; then
  exit 0
fi

git add "$FILE"

if git diff --cached --quiet -- "$FILE"; then
  exit 0
fi

git commit -m "auto sync: update $FILE"
git push origin HEAD:"$BRANCH"
