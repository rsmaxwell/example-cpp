#!/bin/bash

set -x

NAME=example-cpp

ARTIFACTID=${NAME}_amd64-linux
VERSION=${BUILD_ID:-SNAPSHOT}
PACKAGING=zip
ZIPFILE=${ARTIFACTID}_${VERSION}.${PACKAGING}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$(dirname ${SCRIPT_DIR})
BUILD_DIR=${PROJECT_DIR}/build
PACKAGE_DIR=${PROJECT_DIR}/package

rm -rf ${PACKAGE_DIR}
mkdir -p ${PACKAGE_DIR}

cd ${BUILD_DIR}
zip ${PACKAGE_DIR}/${ZIPFILE} ${NAME}

tree ${PROJECT_DIR}
