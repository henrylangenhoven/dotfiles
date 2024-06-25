#!/bin/bash

# Path to your file
repo_file="$DOTFILES/entrnce/.repos"

# Destination folder for cloning (hardcoded)
destination_folder="$ENTRNCE"

# Prompt for GitHub username and password
read -r -p "Enter your GitHub username: " username
read -r -s -p "Enter your GitHub password: " password
echo

# Check if the file exists
if [ ! -f "$repo_file" ]; then
  echo "File $repo_file not found."
  exit 1
fi

# Function to clone a single repository
clone_repo() {
  local repo=$1
  local destination="$destination_folder/$repo"

  # Create destination folder if it doesn't exist
  mkdir -p "$destination"

  # Clone the repository into the specified destination folder
  git clone "https://${username}:${password}@github.com/EnergyExchangeEnablersBV/$repo.git" "$destination"
}

# Loop through each line in the file and clone repos concurrently
while IFS= read -r repo || [[ -n "$repo" ]]; do
  clone_repo "$repo" &
done < "$repo_file"

# Wait for all background tasks to complete
wait

echo "All repositories have been cloned."
