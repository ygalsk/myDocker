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
DOCKERFILE_DIR="$(pwd)"

echo "${blue}Building Docker image...${reset}"
# Build the Docker image and capture output
build_output=$(docker build -t "$IMAGE_NAME" "$DOCKERFILE_DIR" 2>&1)

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "${green}Docker image built successfully.${reset}"
else
    echo "${red}Failed to build Docker image:${reset}"
    echo "$build_output" | tail -n 5  # Show last 5 lines of build output
    exit 1  # Exit script with error code
fi

echo "${blue}Starting Docker container...${reset}"
# Run the Docker container
docker run -it --rm --name "$CONTAINER_NAME" "$IMAGE_NAME"