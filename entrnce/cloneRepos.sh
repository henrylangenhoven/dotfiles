#!/bin/bash

# Path to your file
repo_file="/d/lang/dotfiles/entrnce/.repos"

# Destination folder for cloning (hardcoded)
destination_folder="/d/entrnce"
username="henrylangenhoven"

# Prompt for GitHub token
read -r -s -p "Enter your GitHub token: " token
echo

# Check if the file exists
if [ ! -f "$repo_file" ]; then
  echo "File $repo_file not found."
  exit 1
fi

# Function to clone a single repository
clone_repo() {
  local repo="$1"
  # Remove carriage returns if present
  repo=$(echo "$repo" | tr -d '\r')
  local destination="$destination_folder/$repo"

  # Create destination folder if it doesn't exist
  mkdir -p "$destination"

  # Clone the repository into the specified destination folder
  echo "will now run: git clone \"https://${username}:${token}@github.com/EnergyExchangeEnablersBV/${repo}.git\" \"$destination\""
  git clone "https://${username}:${token}@github.com/EnergyExchangeEnablersBV/${repo}.git" "$destination"
}

# Loop through each line in the file and clone repos concurrently
while IFS= read -r repo || [[ -n "$repo" ]]; do
  repo=$(echo "$repo" | tr -d '\r')
  clone_repo "$repo" &
done < "$repo_file"

# Wait for all background tasks to complete
wait

echo "All repositories have been cloned."
