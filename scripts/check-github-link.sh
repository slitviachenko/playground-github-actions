#!/bin/bash

NAME="[Checking GitHub Link]"
GITHUB_LINK=$1
EXIT_CODE_SUCCESS=0
EXIT_CODE_ERROR=1

if [ -z "${GITHUB_LINK}" ]; then
    echo "${NAME}: A link to the GitHub repo was not provided." 1>&2
    exit ${EXIT_CODE_ERROR}
fi

git ls-remote --tags "${GITHUB_LINK}"
exitCode=$?
if [ ${exitCode} -eq 0 ]; then
    echo "${NAME}: SUCCESS"
    exit ${EXIT_CODE_SUCCESS}
else
    echo "${NAME}: A link to the GitHub repo is incorrect or the GitHub repo is not public." 1>&2
    exit ${EXIT_CODE_ERROR}
fi
