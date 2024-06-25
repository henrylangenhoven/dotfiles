#!/bin/bash

# Path to your file
repo_file="$DOTFILES/entrnce/.repos"

# Destination folder for cloning
destination_folder="$ENTRNCE"

# Check if the file exists
if [ ! -f "$repo_file" ]; then
  echo "File $repo_file not found."
  exit 1
fi

# Change directory to the destination folder
cd "$destination_folder" || exit

# Function to update a single repository
update_repo() {
  local repo=$1
  if [ -d "$repo" ]; then
    echo "Updating $repo ..."
    # Change into the repository directory
    cd "$repo" || return
    # Pull changes from the remote repository
    git pull
    # Go back to the main directory
    cd "$destination_folder" || exit
  else
    echo "Skipping $repo - Directory not found."
  fi
}

# Loop through each line in the file and update repos concurrently
while IFS= read -r repo || [[ -n "$repo" ]]; do
  update_repo "$repo" &
done < "$repo_file"

# Wait for all background tasks to complete
wait

echo "All repositories have been updated."
