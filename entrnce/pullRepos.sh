#!/bin/bash

# Path to your file
repo_file="$HOME/dotfiles/entrnce/.repos"

# Destination folder for cloning
destination_folder="$HOME/entrnce"

# Check if the file exists
if [ ! -f "$repo_file" ]; then
  echo "File $repo_file not found."
  exit 1
fi

# Change directory to the destination folder
cd "$destination_folder" || exit

# Loop through each line in the file
while IFS= read -r repo || [[ -n "$repo" ]]; do
  # Check if the folder exists (repository is cloned)
  if [ -d "$repo" ]; then
    echo "Updating $repo ..."
    # Change into the repository directory
    cd "$repo" || continue
    # Pull changes from the remote repository
    git pull
    # Go back to the main directory
    cd "$destination_folder" || exit
  else
    echo "Skipping $repo - Directory not found."
  fi
done < "$repo_file"
