#!/usr/bin/env bash
set -euo pipefail
REPO_URL="https://github.com/alisardari3696/alisardari3696.github.io.git"
SITE_URL="https://alisardari3696.github.io"

# ensure script runs from repo root
cd "$(dirname "$0")"

# init git if needed
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init
fi

# stage changes
git add --all

# commit if there are staged changes
if ! git diff --cached --quiet; then
  git commit -m "Publish site updates"
else
  echo "No changes to commit."
fi

# ensure main branch
git branch -M main || true

# add origin if missing
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$REPO_URL"
  echo "Added origin -> $REPO_URL"
else
  echo "Remote origin exists: $(git remote get-url origin)"
fi

# push
git push -u origin main

echo "Push complete. GitHub Pages may take ~1–10 minutes to update."

# quick verification (optional)
echo "Checking published CSS URL..."
curl -I --silent --fail "$SITE_URL/style.css" | head -n 10 || echo "style.css not reachable yet or returned non-200."

# open site in host browser (works in devcontainer if $BROWSER set)
if command -v $BROWSER >/dev/null 2>&1 2>/dev/null; then
  $BROWSER "$SITE_URL" || true
else
  # fallback: try xdg-open (Linux)
  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$SITE_URL" || true
  else
    echo "Open your browser and visit: $SITE_URL"
  fi
fi
