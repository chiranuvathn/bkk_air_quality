#!/bin/bash

# Poetry required Python 3.10+ and pipx
# Install pipx if the system doesn't have it
if ! command -v pipx; then
  echo "pipx is not installed. Starting installation..."
  
  # Check system OS and install accordinly
  SYSTEM_OS=$OSTYPE

  # macOS
  if [ $SYSTEM_OS="darwin"* ]; then
    brew install pipx
    pipx ensurepath
  # Linux
  elif [ $SYSTEM_OS="linux-gnu"* ]; then
    sudo apt update
    sudo apt install pipx
    pipx ensurepath
  # Windows
  else
    scoop install pipx
    pipx ensurepath
  fi

  echo "pipx installation completed"

else
  echo "pipx is already installed"
fi

# Install Poetry if the system doesn't have it
if ! command -v poetry; then
  echo "Poetry is not installed. Starting installation..."

  pipx install poetry

  echo "Poetry installation completed"

else
  echo "Poetry is already installed"
fi
