#!/bin/bash

NAME=example-cpp
ZIPFILE=${NAME}_amd64-linux.zip

BUILD_DIR=./build
PACKAGE_DIR=./package

rm -rf ${PACKAGE_DIR}
mkdir -p ${PACKAGE_DIR}

cd ${PACKAGE_DIR}
cp ${BUILD_DIR}/${NAME} .

zip ../${ZIPFILE} ${NAME}
