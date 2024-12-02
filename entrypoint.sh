#!/bin/sh -l

set -ex

INPUT_GITHUB_TOKEN=$1
#INPUT_GITHUB_TOKEN=${ACTIONS_RUNTIME_TOKEN}
REMOTE_REPO="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
WORKSPACE=/app/workspace

env

git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]" 

mkdir -p $WORKSPACE/${GITHUB_REPOSITORY}
git clone ${REMOTE_REPO} $WORKSPACE/${GITHUB_REPOSITORY}

cd /app
uv run src/example_docker_action/example.py $WORKSPACE/${GITHUB_REPOSITORY}/foo.txt

cd $WORKSPACE/${GITHUB_REPOSITORY}
git add foo.txt
git commit -m "Updated foo.txt"
git push "${REMOTE_REPO}" HEAD:${GITHUB_REF_NAME} --follow-tags $_FORCE_OPTION $_TAGS;