#!/bin/bash

# Path to your file
repo_file="$HOME/dotfiles/entrnce/.repos"

# Destination folder for cloning (hardcoded)
destination_folder="$HOME/dev/entrnce"

# Check if the file exists
if [ ! -f "$repo_file" ]; then
  echo "File $repo_file not found."
  exit 1
fi

# Loop through each line in the file
while IFS= read -r repo || [[ -n "$repo" ]]; do
  # Create destination folder if it doesn't exist
  mkdir -p "$destination_folder/$repo"

  # Clone the repository into the specified destination folder
  git clone "https://github.com/EnergyExchangeEnablersBV/$repo.git" "$destination_folder/$repo"
done < "$repo_file"

