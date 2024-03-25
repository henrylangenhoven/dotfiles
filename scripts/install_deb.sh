#!/bin/bash

# Function to install DEB packages from URLs
install_deb_from_url() {
    URL="$1"
    TEMP_DEB="$(mktemp)" &&
    wget -qO "$TEMP_DEB" "$URL" &&
    sudo dpkg -i "$TEMP_DEB"
    rm -f "$TEMP_DEB"
}

# Check if any arguments were passed
if [ "$#" -eq 0 ]; then
    echo "No URLs provided. Please provide one or more URLs."
    exit 1
fi

# Loop through each URL passed as an argument
for URL in "$@"; do
    echo "Installing from URL: $URL"
    install_deb_from_url "$URL"
    echo "Installation from $URL completed."
done
