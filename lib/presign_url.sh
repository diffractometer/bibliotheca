#!/bin/bash

# Bucket and folder details
BUCKET="pureshit-production"
DIRECTORY="bookshelf_cells"

# Get a list of all files in the specified S3 bucket and directory
FILES=$(aws s3api list-objects --bucket "$BUCKET" --prefix "$DIRECTORY/" --query 'Contents[].Key' --output text)

# Iterate over the files and create a pre-signed URL for each
for file in $FILES; do
    # Generate a pre-signed URL that expires in 300 seconds (5 minutes)
    PRESIGNED_URL=$(aws s3 presign "s3://$BUCKET/$file" --expires-in 300)

    # Output the pre-signed URL
    echo "Pre-signed URL for $file: $PRESIGNED_URL"
done
