#!/bin/bash

# Install Bitwarden CLI if the system doesn't have it
# Must login manually using 'bw login' once the installation is done
if ! command -v bw; then
  echo "Bitwarden CLI is not installed. Starting installation via NPM..."
  
  npm install -g @bitwarden/cli
  
  echo "Installation completed. Proceeding..."
fi

# Unlock Bitwarden and create session key
if SESSION_KEY=$(bw unlock --raw); then
  echo "Session unlocked"

  # Get the ID of .env file
  ITEM_ID=$(bw list items --search "BKK Air Quality - ENV" --session $SESSION_KEY | jq -r '.[0].id')
  echo "Retrived the unique id"

  # Get the content and create a local .env file
  bw get item $ITEM_ID --session $SESSION_KEY | jq -r '.notes' >.env
  echo "Completed .env file setup"

  # Unload the session
  unset SESSION_KEY
  echo "Closed the session"
else
  echo "Session unlock failed"
  ehco "Please check your credential"
  exit 1
fi
