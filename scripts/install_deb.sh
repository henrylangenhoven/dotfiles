#!/bin/bash

# Function to install DEB packages from URLs
install_deb_from_url() {
    URL="$1"
    TEMP_DEB="$(mktemp)" &&
    wget -qO "$TEMP_DEB" "$URL" &&
    sudo dpkg -i "$TEMP_DEB"
    rm -f "$TEMP_DEB"
}

# Check if a URL or file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <deb_url_or_file>"
    exit 1
fi

# If the argument is a file, read URLs from that file
if [ -f "$1" ]; then
    while IFS= read -r URL; do
        echo "Installing from URL: $URL"
        install_deb_from_url "$URL"
        echo "Installation from $URL completed."
    done < "$1"
else
    # If the argument is a URL, install the package directly
    URL="$1"
    echo "Installing from URL: $URL"
    install_deb_from_url "$URL"
    echo "Installation from $URL completed."
fi
