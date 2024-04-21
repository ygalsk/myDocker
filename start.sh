#!/bin/bash

# Name of the Docker image
IMAGE_NAME="dev-env"

# Name of the Docker container
CONTAINER_NAME="dev-container"

# Path to the directory containing the Dockerfile
DOCKERFILE_DIR="$(dirname "$0")"

# Build the Docker image
docker build -t "$IMAGE_NAME" "$DOCKERFILE_DIR"

# Run the Docker container
docker run -it --rm --name "$CONTAINER_NAME" "$IMAGE_NAME"
