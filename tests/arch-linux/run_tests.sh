#!/bin/bash

TARGER_DOCKERFILE="tests/arch-linux/Dockerfile"
TARGET_DOCKER_IMAGE="arch-linux-test"

echo "############"
echo "Building $TARGER_DOCKERFILE from $(pwd) as build context"
docker build -f $TARGER_DOCKERFILE  . -t $TARGET_DOCKER_IMAGE

echo "############"
echo "Running $TARGET_DOCKER_IMAGE docker image..."
docker run --rm $TARGET_DOCKER_IMAGE

