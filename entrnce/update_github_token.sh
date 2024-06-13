#!/bin/bash

# Prompt for the new GitHub token
read -p "Enter your new GitHub token: " NEW_GITHUB_TOKEN
echo

# Define the base URL for the remote repository
BASE_URL="github.com/EnergyExchangeEnablersBV/"

# Read the list of repositories from the .repos file
REPO_FILE=".repos"
if [ ! -f "${REPO_FILE}" ]; then
  echo "The .repos file does not exist. Please create it and list your repositories."
  exit 1
fi

# Directory where your repositories are cloned
BASE_DIR="$HOME/entrnce"

# Iterate through each repository listed in the .repos file and update the remote URL
while IFS= read -r REPO; do
  REPO_DIR="${BASE_DIR}/${REPO}"

  if [ -d "${REPO_DIR}" ]; then
    cd "${REPO_DIR}" || exit
    echo "Updating remote URL for ${REPO}..."

    # Get the current remote URL
    CURRENT_URL=$(git remote get-url origin)

    # Extract the repository path from the current URL
    REPO_PATH=$(echo "${CURRENT_URL}" | sed "s@https://.*@${BASE_URL}${REPO}.git@")

    # Construct the new remote URL
    NEW_URL="https://henrylangenhoven:${NEW_GITHUB_TOKEN}@${REPO_PATH}"

    # Set the new remote URL
    git remote set-url origin "${NEW_URL}"

    echo "Updated remote URL for ${REPO} to ${NEW_URL}"
  else
    echo "Directory ${REPO_DIR} does not exist, skipping..."
  fi
done < "${REPO_FILE}"

echo "All repositories have been updated."
