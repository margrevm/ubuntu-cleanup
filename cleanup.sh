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

NB_DAYS_TO_KEEP=60

# Remove files older than NB_DAYS_TO_KEEP days in the specified folders
echo "[Removing old files]"
for CLEANUP_DIR in "${CLEANUP_DIRS[@]}"; do
    if [ -d "$CLEANUP_DIR" ]; then

        echo "➜ Files older than $NB_DAYS_TO_KEEP days in '$CLEANUP_DIR':"
        FILES_TO_DELETE=$(find "$CLEANUP_DIR" -type f -mtime +$NB_DAYS_TO_KEEP -name '*')
        if [ -z "$FILES_TO_DELETE" ]; then
            echo "  No files to delete."
            continue
        fi

        # Print file list with sizes
        echo "$FILES_TO_DELETE" | xargs -d '\n' -r ls -lh | awk '{print $9, $5}'
        
        # Calculate total size and ask for confirmation
        TOTAL_SIZE=$(echo "$FILES_TO_DELETE" | xargs -d '\n' -r du -ch 2>/dev/null | grep total$ | awk '{print $1}')

        # Ensure TOTAL_SIZE is a single line
        TOTAL_SIZE=$(echo "$TOTAL_SIZE" | tr -d '\n')
        echo ""
        read -p "Delete these files (Total size: $TOTAL_SIZE)? [y/N]: " CONFIRM

        if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
            echo "Deleting files..."
            # Delete the files
            find "$CLEANUP_DIR" -type f -mtime +$NB_DAYS_TO_KEEP -name '*' -exec rm -v {} \;
        else
            echo "Skipped deleting files in '$CLEANUP_DIR'."
        fi
    else
        echo "➜ Directory '$CLEANUP_DIR' does not exist. Skipping..."
    fi
done

# ---------------------------------------------------
# Clean trash
# ---------------------------------------------------
# Trash is cleaned by setting a period in Settings->Privacy->File History & Trash

