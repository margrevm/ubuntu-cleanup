#!/bin/bash

## Script to clean up disk space (unnecessary or old files, cache, ...)
##
## Copyright (C) 2025 Mike Margreve (mike.margreve@outlook.com)
## Permission to copy and modify is granted under the foo license
##
## Usage: cleanup [no arguments]

# ---------------------------------------------------
# Remove old files
# ---------------------------------------------------

CLEANUP_DIRS=(
	$HOME/Downloads
	$HOME/Pictures/Screenshots
)

NB_DAYS_TO_KEEP=90

# Remove files older than NB_DAYS_TO_KEEP days in the specified folders
echo "[Removing old files]"
for CLEANUP_DIR in "${CLEANUP_DIRS[@]}"; do
    if [ -d "$CLEANUP_DIR" ]; then
        echo "➜ Remove files older than $NB_DAYS_TO_KEEP from '$CLEANUP_DIR' folder..."
        find "$CLEANUP_DIR" -type f -mtime +$NB_DAYS_TO_KEEP -name '*' -delete -print
    else
        echo "➜ Directory '$CLEANUP_DIR' does not exist. Skipping..."
    fi
done

# ---------------------------------------------------
# Clean trash
# ---------------------------------------------------
# Trash is cleaned by setting a period in Settings->Privacy->File History & Trash

