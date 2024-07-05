#!/bin/bash

# Prompt for client_id and client_secret
read -p "Enter your client_id: " CLIENT_ID
read -sp "Enter your client_secret: " CLIENT_SECRET
echo

# Concatenate client_id and client_secret with a colon
CREDENTIALS="${CLIENT_ID}:${CLIENT_SECRET}"

# Base64 encode the credentials
ENCODED_CREDENTIALS=$(echo -n "${CREDENTIALS}" | base64)

# Output the encoded credentials
echo "Base64 encoded credentials: ${ENCODED_CREDENTIALS}"
