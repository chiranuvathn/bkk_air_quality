#!/bin/bash

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
  exit 1
fi
