#!/bin/bash

BUILD_DIR=./build

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

export SOURCE=./src/main/cpp

make --file ./src/main/make/linux_amd64.makefile $*
