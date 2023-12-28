#!/bin/bash

# Target directory for original images
TARGET_DIR="src/test/resources/bookshelf_cells"

# Target directory for small images
TARGET_DIR_SMALL="${TARGET_DIR}/small"

# File types to consider
FILE_TYPES=("*.jpg" "*.jpeg" "*.png")

# Create the small directory if it doesn't exist
mkdir -p "$TARGET_DIR_SMALL"

# Loop through each file type
for TYPE in "${FILE_TYPES[@]}"; do
  # Find images in the target directory (not recursive to subdirectories)
  find "$TARGET_DIR" -maxdepth 1 -type f -iname "$TYPE" | while read -r IMAGE; do
    # Define the new image path in the small directory
    BASENAME=$(basename "$IMAGE")
    NEW_IMAGE="${TARGET_DIR_SMALL}/${BASENAME}"

    # Resize the image to 80x60
    convert "$IMAGE" -resize 80x60 "$NEW_IMAGE"
    echo "Created small image $NEW_IMAGE."
  done
done

echo "All small images have been created in $TARGET_DIR_SMALL."
