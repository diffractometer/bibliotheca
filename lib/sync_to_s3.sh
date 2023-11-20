#!/bin/bash

# Set the local directory path and S3 bucket name
LOCAL_DIR="src/test/resources/bookshelf_cells"
S3_BUCKET="s3://pureshit-production/bookshelf_cells"

# Sync only JPEG files to the S3 bucket folder 'bookshelf_cells'
aws s3 sync $LOCAL_DIR $S3_BUCKET --exclude "*" --include "*.jpeg" --include "*.jpg"

# Check if the sync command was successful
if [ $? -eq 0 ]; then
    echo "Sync of JPEG files to the 'bookshelf_cells' directory in S3 bucket was successful."
else
    echo "Sync of JPEG files to the 'bookshelf_cells' directory in S3 bucket failed."
fi
