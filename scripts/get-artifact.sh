#!/bin/sh

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $(dirname $BASEDIR) && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build
DIST_DIR=${PROJECT_DIR}/dist
DOWNLOADS_DIR=${PROJECT_DIR}/downloads

. ${BUILD_DIR}/buildinfo

PROJECT=example-cpp
GROUPID=com.rsmaxwell.example
ARTIFACTID=${PROJECT}_${FAMILY}_${ARCHITECTURE}
PACKAGING=zip

if [ -z "${BUILD_ID}" ]; then
    VERSION="0.0-SNAPSHOT"
    REPOSITORY=snapshots
    REPOSITORYID=snapshots
else
    VERSION=${BUILD_ID}
    REPOSITORY=releases
    REPOSITORYID=releases
fi

URL=https://pluto.rsmaxwell.co.uk/archiva/repository/${REPOSITORY}

ZIPFILE=${ARTIFACTID}_${VERSION}.${PACKAGING}

cd ${DIST_DIR}

mvn --batch-mode --errors dependency:get \
	-DremoteRepositories=${URL} \
	-DgroupId=${GROUPID} \
	-DartifactId=${ARTIFACTID} \
	-Dversion=${VERSION} \
	-Dpackaging=${PACKAGING} \
	-Dtransitive=false
result=$?
if [ ! ${result} -eq 0 ]; then
    echo "deployment failed"
    echo "Error: $0[${LINENO}] result: ${result}"
    exit 1
fi


mkdir -p ${DOWNLOADS_DIR}

mvn --batch-mode --errors dependency:copy \
	-Dartifact=${GROUPID}:${ARTIFACTID}:${VERSION}:${PACKAGING} \
	-DoutputDirectory=${DOWNLOADS_DIR}
result=$?
if [ ! ${result} -eq 0 ]; then
    echo "deployment failed"
    echo "Error: $0[${LINENO}] result: ${result}"
    exit 1
fi


echo "Success"

