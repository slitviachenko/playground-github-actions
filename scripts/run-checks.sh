#!/bin/bash

GITHUB_URL=$1
NPM_URL=$2
EXIT_CODE_SUCCESS=0
EXIT_CODE_ERROR=1

./check-github-link.sh "${GITHUB_URL}"
checkGithubLinkExitCode=$?
./check-npm-link.sh "${NPM_URL}"
checkNPMLinkExitCode=$?

printf "\ncheckGithubLinkExitCode=${checkGithubLinkExitCode}"
printf "\ncheckNPMLinkExitCode=${checkNPMLinkExitCode}"
printf "\n\n"
