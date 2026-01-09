#!/bin/bash

## Script to clean up disk space (unnecessary or old files, cache, ...)
##
## Copyright (C) 2026 Mike Margreve (mike.margreve@outlook.com)
## Permission to copy and modify is granted under the foo license
##
## Usage: cleanup [no arguments]

# ---------------------------------------------------
# Remove old files
# ---------------------------------------------------

CLEANUP_DIRS=(
    "$HOME/Downloads"
    "$HOME/Pictures/Screenshots"
    "$HOME/Screencasts"
)

NB_DAYS_TO_KEEP=60

# Remove files older than NB_DAYS_TO_KEEP days in the specified folders
printf '\033[1;31m[Removing old files & folders]\033[0m\n'
for CLEANUP_DIR in "${CLEANUP_DIRS[@]}"; do
    if [ -d "$CLEANUP_DIR" ]; then

        printf '\033[0;31m➜ Files older than %s days in '\''%s'\''\033[0m\n' "$NB_DAYS_TO_KEEP" "$CLEANUP_DIR"
        FILES_TO_DELETE=$(find "$CLEANUP_DIR" -type f -mtime +$NB_DAYS_TO_KEEP -name '*')
        if [ -z "$FILES_TO_DELETE" ]; then
            echo "No files to delete."
            continue
        fi

        # Print file list with sizes
        echo "$FILES_TO_DELETE" | xargs -d '\n' -r ls -lh | awk '{print $9, $5}'
        
        # Calculate total size and ask for confirmation
        TOTAL_SIZE=$(echo "$FILES_TO_DELETE" | xargs -d '\n' -r du -ch 2>/dev/null | grep total$ | awk '{print $1}')

        # Ensure TOTAL_SIZE is a single line
        TOTAL_SIZE=$(echo "$TOTAL_SIZE" | tr -d '\n')
        printf '\n'
        read -p "Delete these files (Total size: $TOTAL_SIZE)? [y/N]: " CONFIRM

        if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
            echo "Deleting files..."
            # Delete the files
            find "$CLEANUP_DIR" -type f -mtime +$NB_DAYS_TO_KEEP -name '*' -exec rm -v {} \;
        else
            echo "Skipped deleting files in '$CLEANUP_DIR'."
        fi
    else
        printf '\033[0;31m➜ Directory '\''%s'\'' does not exist. Skipping...\033[0m\n' "$CLEANUP_DIR"
    fi
done

# ---------------------------------------------------
# Remove empty folders (recursively in the given folders)
# ---------------------------------------------------
REMOVE_EMPTY_DIRS=(
    "$HOME/Downloads"
    "$HOME/Pictures/Screenshots"
)

printf '\033[0;31m➜ Removing empty folders\033[0m\n'
for REMOVE_EMPTY_DIR in "${REMOVE_EMPTY_DIRS[@]}"; do
    if [ -d "$REMOVE_EMPTY_DIR" ]; then
        if [ -z "$(find "$REMOVE_EMPTY_DIR" -depth -type d -empty)" ]; then
            # print message that nothing has been found if no empty folders were found
            printf 'No empty folders found in '\''%s'\''\n' "$REMOVE_EMPTY_DIR"
        fi  

        find "$REMOVE_EMPTY_DIR" -depth -type d -empty -exec rmdir -v {} \;
    fi
done

# ---------------------------------------------------
# Remove dirs
# ---------------------------------------------------
REMOVE_DIRS=(
    "$HOME/Screencasts"
    "$HOME/cpdb"
)

printf '\033[0;31m➜ Removing folders\033[0m\n'
rm -rfv -- "${REMOVE_DIRS[@]}"

# ---------------------------------------------------
# Clean trash
# ---------------------------------------------------
# Trash is cleaned by setting a period in Settings->Privacy->File History & Trash

