#!/bin/bash

# Target directory
TARGET_DIR="src/test/resources/bookshelf_cells"

# File types to consider
FILE_TYPES=("*.jpg" "*.jpeg" "*.png")

# Loop through each file type
for TYPE in "${FILE_TYPES[@]}"; do
  # Find images in the target directory and its subdirectories
  find "$TARGET_DIR" -type f -iname "$TYPE" | while read -r IMAGE; do
    # Get image width and height
    WIDTH=$(identify -format "%w" "$IMAGE")
    HEIGHT=$(identify -format "%h" "$IMAGE")

    # Determine the long and short sides
    LONG_SIDE=$(( WIDTH > HEIGHT ? WIDTH : HEIGHT ))
    SHORT_SIDE=$(( WIDTH <= HEIGHT ? WIDTH : HEIGHT ))

    # Resize conditionally
    if [ "$LONG_SIDE" -gt 2000 ] || [ "$SHORT_SIDE" -gt 768 ]; then
      # Calculate aspect ratio
      RATIO=$(echo "scale=3; $LONG_SIDE / $SHORT_SIDE" | bc)
      # Calculate new sizes
      if [ "$LONG_SIDE" -eq "$WIDTH" ]; then
        NEW_WIDTH=2000
        NEW_HEIGHT=$(echo "scale=0; 2000 / $RATIO" | bc)
      else
        NEW_HEIGHT=768
        NEW_WIDTH=$(echo "scale=0; 768 * $RATIO" | bc)
      fi
      # Ensure new sizes are not exceeding the maximum
      if [ "$NEW_WIDTH" -gt 2000 ]; then
        NEW_WIDTH=2000
      fi
      if [ "$NEW_HEIGHT" -gt 768 ]; then
        NEW_HEIGHT=768
      fi
      # Resize the image
      convert "$IMAGE" -resize "${NEW_WIDTH}x${NEW_HEIGHT}" "$IMAGE"
      echo "Resized $IMAGE to ${NEW_WIDTH}x${NEW_HEIGHT}."
    else
      echo "$IMAGE does not need resizing."
    fi
  done
done
