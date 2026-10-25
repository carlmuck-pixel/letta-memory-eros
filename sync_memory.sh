#!/bin/bash
# Commit and push this agent's memory repo.
#
# Repo-relative on purpose: the repo is wherever this script lives, so there are
# no agent IDs here to go stale when an agent is recreated (or copied to another
# machine). Safe to run from cron/launchd for a background sync.
set -e
cd "$(dirname "$0")"

if [ ! -d .git ]; then
  echo "not a git repo: $(pwd)" >&2
  exit 1
fi

git pull --rebase origin main >/dev/null 2>&1 || echo "pull skipped (offline, or uncommitted changes)"

if git diff --quiet && git diff --cached --quiet \
   && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "No memory changes"
else
  git add -A
  git commit -m "sync: auto-commit $(date -u +%Y-%m-%dT%H:%M:%SZ)" >/dev/null || true
  if git push origin main >/dev/null 2>&1; then
    echo "Pushed $(git rev-parse --short HEAD)"
  else
    echo "Push failed — commit stays local ($(git rev-parse --short HEAD)); re-run to retry"
  fi
fi
