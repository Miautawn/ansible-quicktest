#!/bin/bash

TEST_DIR=$(dirname "$0")

TARGER_DOCKERFILE="$TEST_DIR/Dockerfile"
TARGET_DOCKER_IMAGE="arch-linux-test"
TARGET_CMD="$TEST_DIR/entry.sh"

echo "############"
echo "Building $TARGER_DOCKERFILE from $(pwd) as build context"
echo "############"
docker build -f $TARGER_DOCKERFILE  . -t $TARGET_DOCKER_IMAGE

echo "############"
echo "Running $TARGET_DOCKER_IMAGE docker image with command: '$TARGET_CMD'"
echo "############"
docker run --rm -it $TARGET_DOCKER_IMAGE "$TARGET_CMD"