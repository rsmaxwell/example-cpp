#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/build

. ${BUILD_DIR}/buildinfo



SOURCE=${PROJECT_DIR}/src/main/c
export SOURCE

make --file ${PROJECT_DIR}/src/main/make/${FAMILY}_${ARCHITECTURE}.makefile $*

