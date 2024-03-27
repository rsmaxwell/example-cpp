#!/bin/sh

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build
PACKAGE_DIR=${PROJECT_DIR}/package
DIST_DIR=${PROJECT_DIR}/dist

. ${BUILD_DIR}/buildinfo

PROJECT=example-cpp
ARTIFACTID=${PROJECT}_${FAMILY}_${ARCHITECTURE}
PACKAGING=zip

if [ -z "${BUILD_ID}" ]; then
    VERSION="0.0-SNAPSHOT"
else
    VERSION=${BUILD_ID}
fi

ZIPFILE=${ARTIFACTID}_${VERSION}.${PACKAGING}

rm -rf ${PACKAGE_DIR} ${DIST_DIR}
mkdir -p ${PACKAGE_DIR} ${DIST_DIR}

cd ${PACKAGE_DIR}
cp ${BUILD_DIR}/${PROJECT} .

zip ${DIST_DIR}/${ZIPFILE} ${PROJECT}
result=$?
if [ ! ${result} -eq 0 ]; then
    echo "packaging failed"
    echo "Error: $0[${LINENO}] result: ${result}"
    exit 1
fi

echo "Success"

