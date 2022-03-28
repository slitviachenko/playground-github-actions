#!/bin/bash

NAME="[Checking NPM Link]"
NPM_LINK=$1
EXIT_CODE_SUCCESS=0
EXIT_CODE_ERROR=1
NPM_PACKAGE_PATH="https://www.npmjs.com/package/"

if [ -z "${NPM_LINK}" ]; then
    echo "${NAME}: A link to the NPM package was not provided." 1>&2
    exit ${EXIT_CODE_ERROR}
fi

if [[ "${NPM_LINK}" != "${NPM_PACKAGE_PATH}"* ]]; then
    echo "${NAME}: A link to the NPM package is not valid." 1>&2
    exit ${EXIT_CODE_ERROR}
fi
NPM_PACKAGE="${NPM_LINK/$NPM_PACKAGE_PATH/}"

npm view "${NPM_PACKAGE}" name
exitCode=$?
if [ ${exitCode} -eq 0 ]; then
    echo "${NAME}: SUCCESS"
    exit ${EXIT_CODE_SUCCESS}
else
    echo "${NAME}: A link to the NPM package is incorrect or the NPM package doesn't exist." 1>&2
    exit ${EXIT_CODE_ERROR}
fi
