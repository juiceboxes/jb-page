#!/usr/bin/env bash

# Font Colors
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
SET='\033[0m'

MESSAGE=$(git log --format=%B -n 1 $TRAVIS_COMMIT)
cd dist

echo "${GREEN}----- Initializing Repo -----${SET}"
git init

echo "${PURPLE}Setting Travis Login Info${SET}"
git config --global user.name $COMMIT_AUTHOR_USERNAME
git config --global user.email $COMMIT_AUTHOR_EMAIL

echo "${GREEN}----- Setting Up Remote Repo -----${SET}"
git remote add travis-build ${REPO}.git

echo "${PURPLE}Adding dist/${SET}"
git add .
git commit -m 'Build by Travis'
git config --list

echo "${GREEN}----- Pushing to Remote Repo (github.io) -----${SET}"
git push --force --set-upstream travis-build master