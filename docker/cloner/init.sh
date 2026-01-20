#!/bin/sh

set -e
set -u
set -o pipefail

## check if REPO_URL is populated
: "${REPO_URL:?Error: REPO_URL is undefined}" > /dev/null

## Look if there is a folder called .git inside 
DEST_DIR=${WWW_DIR:-"/var/www/html"}
BRANCH=${GIT_BRANCH:-"main"}

echo "Attempte to create $DEST_DIR"
[ ! -d "$DEST_DIR" ] && mkdir -p "$DEST_DIR"

cd "$DEST_DIR"

git config --global --add safe.directory "$DEST_DIR"

if [ -d ".git" ]; then
  echo "Repository initialized: pulling"
  echo "Attempt to set origin"
  git remote set-url origin $REPO_URL
  echo "Track remote branch for: $BRANCH"
  git checkout -B $BRANCH origin/$BRANCH
  echo "Syncing branch"
  git pull
else
  echo "Repository missing: cloning"
  echo "Cleaning the directory first"
  rm -rf .[!.]* /..?*
  echo "Cloning the repository"
  git clone $REPO_URL .
  echo "Switching to branch: $BRANCH"
  git checkout -B $BRANCH origin/$BRANCH
  echo "Syncing branch"
  git pull
fi
