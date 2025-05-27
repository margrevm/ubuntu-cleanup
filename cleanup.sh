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
NB_DAYS_TO_KEEP=60

echo "[Remove old files]"
echo "➜ Remove files older than $NB_DAYS_TO_KEEP from 'Downloads' folder..."

find $HOME/Downloads/ -type f -mtime +$NB_DAYS_TO_KEEP -name '*' -delete
