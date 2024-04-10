#!/bin/bash

# Find and remove files older than 7 days in the Downloads directory
find $HOME/Downloads -type f -mtime +7 -exec rm -f {} \;