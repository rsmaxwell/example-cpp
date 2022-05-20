#!/bin/bash

PROJECT_DIR=$(pwd)
BUILD_DIR=${PROJECT_DIR}/build

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

export SOURCE=${PROJECT_DIR}/src/main/cpp

make --file ${PROJECT_DIR}/src/main/make/linux_amd64.makefile $*
