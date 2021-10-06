#!/bin/bash

INPUT_IMAGE_NAME=$1
INPUT_DOCKER_TAG=$2
INPUT_BINDER_DOCKER_FILE=$3

if [ -z "$INPUT_IMAGE_NAME" ]; then
  echo "Input the docker image name as the first parameter"
  exit 1
fi 

if [ -z "$INPUT_DOCKER_TAG" ]; then
  echo "Input the docker tag as the second parameter"
  exit 1
fi 

if [ -z "$INPUT_BINDER_DOCKER_FILE" ]; then
  echo "Input the binder dockerfile tag as the third parameter"
  exit 1
fi 

# Set Docker image full name
DOCKER_FULL_IMAGE_NAME="${INPUT_IMAGE_NAME}:${INPUT_DOCKER_TAG}"

# Update dockerfile
START_TEMPLATE="##START_BASE_IMAGE##"
END_TEMPLATE="##END_BASE_IMAGE##"
DOCKER_FROM_STATEMENT="FROM ${DOCKER_FULL_IMAGE_NAME}"
sed -i.bak "/${START_TEMPLATE}/,/${END_TEMPLATE}/c\\${START_TEMPLATE}\n${DOCKER_FROM_STATEMENT}\n${END_TEMPLATE}" ${INPUT_BINDER_DOCKER_FILE}