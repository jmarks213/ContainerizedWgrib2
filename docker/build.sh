#!/bin/bash

BASE_CONTAINER_NAME=jmarks213/containerized_wgrib2
VERSION_TAG=$BASE_CONTAINER_NAME:$(date +%Y%m%d)

echo "Starting to build the wgrib2 container..."

docker build -t "$VERSION_TAG" .

echo "Done building the wgrib2 container..."
