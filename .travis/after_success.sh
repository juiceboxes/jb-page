#!/usr/bin/env bash

# Font Colors
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
SET='\033[0m'

# Font Styles
BOLD='\033[1;36m'

# Check if it is a pull request
if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
    echo -e "${RED}Pull Request --- Skipping secure vars and deploying${SET}"
    echo -e "${PURPLE}Once this Pull Request is merged, vars will be active and will be deployed!${SET}"
    exit 0;
else
    echo "${GREEN}----- Generating Key -----${SET}"
    openssl aes-256-cbc -K $encrypted_5326641bd546_key -iv $encrypted_5326641bd546_iv -in deploy_key.enc -out deploy_key -d
    chmod 600 deploy_key
    eval `ssh-agent -s`
    ssh-add deploy_key
fi

# If current branch is master, push to ___
if [ "${TRAVIS_BRANCH}" = "master" ]; then
    echo "${GREEN}----- Master Branch: Deploying to Github Pages Repo -----${SET}"
    .travis/release.sh
fi