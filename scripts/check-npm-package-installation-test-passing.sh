#!/bin/bash

NAME="[NPM Package]"
SCRIPT_NAME=$(basename $0)
NPM_PACKAGE=$1
EXIT_CODE_SUCCESS=0
EXIT_CODE_ERROR=1
NPM_PACKAGE_PARH="https://www.npmjs.com/package/"
NPM_PACKAGE_TEST_DIR="./npm-package"

# $1 (Optional) An error messsage to output to stderr.
function printErrorMsgAndTerminateScript() {
    if [[ ! -z "$1" ]]; then
        echo "${NAME}: $1" 1>&2
    else
        echo "${NAME}: FAILED" 1>&2
    fi
    exit ${EXIT_CODE_ERROR}
}

if [ -z "${NPM_PACKAGE}" ]; then
    printErrorMsgAndTerminateScript "An NPM package name was not provided."
fi
NPM_PACKAGE="${NPM_PACKAGE/$NPM_PACKAGE_PARH/}"

rm -fr ${NPM_PACKAGE_TEST_DIR} || printErrorMsgAndTerminateScript
mkdir -p ${NPM_PACKAGE_TEST_DIR} || printErrorMsgAndTerminateScript
cd ${NPM_PACKAGE_TEST_DIR} || printErrorMsgAndTerminateScript
npm init --yes >/dev/null 2>&1 || printErrorMsgAndTerminateScript
npm install "${NPM_PACKAGE}" >/dev/null 2>&1 || printErrorMsgAndTerminateScript "A package installation failed."
cp -R "./node_modules/${NPM_PACKAGE}" "installed-npm-package-src" || printErrorMsgAndTerminateScript
cd "installed-npm-package-src" || printErrorMsgAndTerminateScript
npm install --legacy-peer-deps || printErrorMsgAndTerminateScript "A package's dependencies installation failed."
npm test || printErrorMsgAndTerminateScript "A package didn't pass its own tests."

echo "${NAME}: SUCCESS"
exit ${EXIT_CODE_SUCCESS}
