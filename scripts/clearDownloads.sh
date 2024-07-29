#!/bin/bash

# Find and remove files older than 7 days in the Downloads directory
find $HOME/Downloads -type f -mtime +7 -exec rm -f {} \; 2>/dev/null

# Find and remove empty directories in the Downloads directory
find $HOME/Downloads -type d -empty -exec rmdir {} \; 2>/dev/null
