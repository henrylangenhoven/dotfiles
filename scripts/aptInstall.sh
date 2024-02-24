#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt autoremove -y

apt_file="/home/henry/dotfiles/scripts/.apt"

# Sort the file and remove duplicates
sort "$apt_file" | uniq > "$apt_file".tmp

# Replace the original file with the sorted one
mv "$apt_file".tmp "$apt_file"
sudo chown henry ~/dotfiles/scripts/.apt

# Initialize an empty string to hold the package names
packages=""

# Read the .apt file line by line
while IFS= read -r line
do
  # Concatenate the package names
  packages="$packages $line"
done < "$apt_file"

# Run the apt install command with the package names
sudo apt install -y $packages