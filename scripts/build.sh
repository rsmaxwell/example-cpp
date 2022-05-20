#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$(dirname ${SCRIPT_DIR})
BUILD_DIR=${PROJECT_DIR}/build

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

export SOURCE=${PROJECT_DIR}/src/main/cpp

make --file ${PROJECT_DIR}/src/main/make/linux_amd64.makefile $*
