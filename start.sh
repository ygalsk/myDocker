#!/bin/bash

# Custom colors
blue=$'\033[0;34m'
green=$'\033[0;32m'
red=$'\033[0;31m'
reset=$'\033[0;39m'

# Name of the Docker image
IMAGE_NAME="dev-env"

# Name of the Docker container
CONTAINER_NAME="dev-container"

# Path to the directory containing the Dockerfile
DOCKERFILE_DIR="$(dirname "$0")"

echo "${blue}Building Docker image...${reset}"
# Build the Docker image with increased verbosity
docker build --progress=plain -t "$IMAGE_NAME" "$DOCKERFILE_DIR" && \
echo "${green}Docker image built successfully.${reset}"

echo "${blue}Starting Docker container...${reset}"
# Run the Docker container
docker run -it --rm --name "$CONTAINER_NAME" "$IMAGE_NAME"
