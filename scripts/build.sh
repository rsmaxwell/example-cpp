#!/bin/sh


FAMILY=""
ARCHITECTURE=""

case "$(uname -s)" in
    CYGWIN*) FAMILY="cygwin" ;;
    Linux*) 
        . /etc/os-release
        case ${ID} in
            ubuntu) FAMILY="linux" ;;
            alpine) FAMILY="alpine" ;;
            *) FAMILY="linux" ;;
        esac
        ;;
    *) FAMILY="unknown" ;;
esac

case "$(uname -m)" in 
  amd64|x86_64)   ARCHITECTURE="amd64" ;; 
  *) ARCHITECTURE="x86" ;; 
esac 


if [ -z "${BUILD_ID}" ]; then
    VERSION="0.0-SNAPSHOT"
    REPOSITORY=snapshots
    REPOSITORYID=snapshots
else
    VERSION=${BUILD_ID}
    REPOSITORY=releases
    REPOSITORYID=releases
fi


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}



cat > buildinfo <<EOL
FAMILY="${FAMILY}"
ARCHITECTURE="${ARCHITECTURE}"
VERSION="${VERSION}"
REPOSITORY="${REPOSITORY}"
REPOSITORYID="${REPOSITORYID}"
EOL

pwd
ls -al 
cat buildinfo



SOURCE=${PROJECT_DIR}/src/main/c
export SOURCE

make --file ${PROJECT_DIR}/src/main/make/${FAMILY}_${ARCHITECTURE}.makefile $*

