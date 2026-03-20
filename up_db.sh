#!/bin/bash

# Ignore any lines starts with '#' (comments)
# Load variables from .env into the terminal session
export $(grep -v '^#' .env | xargs)

# Start the containers in the background
# Ensure any changes to config are picked up
docker compose up -d --build

echo ""
echo "Containers are up!"
