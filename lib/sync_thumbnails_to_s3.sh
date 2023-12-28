#!/bin/bash

# Set the local directory path for the small images
LOCAL_DIR_SMALL="src/test/resources/bookshelf_cells/small"

# Set the S3 bucket name and path for small images
S3_BUCKET_SMALL="s3://pureshit-production/bookshelf_cells/small"

# Sync only JPEG files from the 'small' directory to the S3 bucket's 'small' folder
aws s3 sync $LOCAL_DIR_SMALL $S3_BUCKET_SMALL --exclude "*" --include "*.jpeg" --include "*.jpg"

# Check if the sync command was successful
if [ $? -eq 0 ]; then
    echo "Sync of JPEG files to the 'bookshelf_cells/small' directory in S3 bucket was successful."
else
    echo "Sync of JPEG files to the 'bookshelf_cells/small' directory in S3 bucket failed."
fi
