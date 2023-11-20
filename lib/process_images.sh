#!/bin/bash

# Script-wide variables
PROMPT="Please list in CSV format the title, genre, and author of each book visible in this image. If a book's title, author, or genre is partly obscured, provide your best guess. The CSV format should strictly be 'title, genre, author' with each book on a new line. Do not include any text other than the CSV-formatted information."
BUCKET="pureshit-production"
DIRECTORY="bookshelf_cells"

# Directory for CSV output
CSV_DIR="src/test/resources/csv"
mkdir -p "$CSV_DIR"

# Generate a unique filename for the CSV
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")
short_uuid=$(uuidgen | head -c 4)
csv_filename="${CSV_DIR}/books_${current_date_time}_${short_uuid}.csv"

# Function to generate a pre-signed URL for an S3 object
generate_presigned_url() {
    local object_path=$1
    echo $(aws s3 presign "s3://$BUCKET/$object_path" --expires-in 300)
}

# Function to send image to OpenAI for analysis and write to CSV
analyze_image() {
    local image_url=$1
    local response=$(curl -s https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d '{
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": "'"$PROMPT"'"
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "'"$image_url"'"
                }
              }
            ]
          }
        ],
        "max_tokens": 300
      }')

    # Parse the response and write to CSV
    echo $response | jq -r '.choices[0].message.content' >> "$csv_filename"
}

# Create the CSV file and add a header
echo "title,genre,author" > "$csv_filename"

# List objects in the S3 bucket and directory
objects=$(aws s3api list-objects --bucket "$BUCKET" --prefix "$DIRECTORY/" --query 'Contents[].Key' --output text)

# Iterate over each object and process it
for object in $objects; do
    presigned_url=$(generate_presigned_url "$object")
    echo "Analyzing image: $object"
    analyze_image "$presigned_url"
done

# Output the location of the CSV file
echo "CSV file created at: $csv_filename"
