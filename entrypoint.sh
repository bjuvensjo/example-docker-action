#!/bin/sh -l

set -ex

INPUT_GITHUB_TOKEN=$1
REPOSITORY_OWNER=bjuvensjo
REPOSITORY=slask
BRANCH=main
REMOTE_REPO="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${REPOSITORY_OWNER}/${REPOSITORY}.git"
WORKSPACE=/app/workspace

env

git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]" 

mkdir $WORKSPACE
git clone ${REMOTE_REPO} $WORKSPACE/${REPOSITORY}

cd /app
uv run src/example_docker_action/example.py $WORKSPACE/${REPOSITORY}/foo.txt

cd $WORKSPACE/${REPOSITORY}
git add foo.txt
git commit -m "Updated foo.txt"
git push "${REMOTE_REPO}" HEAD:${BRANCH} --follow-tags $_FORCE_OPTION $_TAGS;