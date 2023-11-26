#!/bin/bash

# Script-wide variables
PROMPT="For each book visible in the images, provide the title and author in CSV format. If a book's title or author cannot be determined, respond with 'null' in the appropriate field. List each book from each image on a new line."
BUCKET="pureshit-production"
DIRECTORY="bookshelf_cells"
LOG_DIR="src/test/resources/logs"
CSV_DIR="src/test/resources/csv"

# Ensure CSV and log directories exist
mkdir -p "$CSV_DIR"
mkdir -p "$LOG_DIR"

# Generate unique filenames for the CSV and log
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")
short_uuid=$(uuidgen | head -c 4)
csv_filename="${CSV_DIR}/books_${current_date_time}_${short_uuid}.csv"
log_filename="${LOG_DIR}/books_${current_date_time}_${short_uuid}.log"

# Function to generate a pre-signed URL for an S3 object
generate_presigned_url() {
    local object_path=$1
    aws s3 presign "s3://$BUCKET/$object_path" --expires-in 300
}

# Function to analyze images and write to CSV
analyze_images() {
    local image_url_to_object_map=("$@")
    local json_payload='{"model": "gpt-4-vision-preview", "messages": [{"role": "user", "content": [{"type": "text", "text": "'"$PROMPT"'"}'

    # Build the JSON payload with image URLs
    for image_url_object_pair in "${image_url_to_object_map[@]}"; do
        IFS=";" read -r image_url object_path <<< "$image_url_object_pair"
        json_payload+=', {"type": "image_url", "image_url": {"url": "'"$image_url"'"}}'
    done

    json_payload+=' ]}], "max_tokens": 300}'

    echo "Analyzing images..." | tee -a "$log_filename"
    local response=$(curl -s https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d "$json_payload")

    # Log the full response
    echo "$response" | tee -a "$log_filename"

    # Check if the response is valid JSON
    if ! jq empty <<< "$response" >/dev/null 2>&1; then
        echo "Error: Invalid JSON response." | tee -a "$log_filename"
        return 1
    fi

    # Parse the response and write to CSV
    local books=$(echo "$response" | jq -r '.choices[0].message.content' 2>/dev/null)
    if [[ ! -z "$books" ]]; then
        while IFS= read -r line; do
            # Remove quotes and trim leading whitespace from author
            line=$(echo "$line" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/","/,/g; s/^"//; s/"$//;')
            # Append the object location to the line and write to CSV
            echo "$line,$object_path" >> "$csv_filename"
        done <<< "$books"
    fi
}

# Create the CSV file and add a header
echo "title,author,s3_object_location" > "$csv_filename"

# List objects in the S3 bucket and directory and generate pre-signed URLs
objects=($(aws s3api list-objects --bucket "$BUCKET" --prefix "$DIRECTORY/" --query 'Contents[].Key' --output text))
image_url_to_object_map=()

for object in "${objects[@]}"; do
    image_url=$(generate_presigned_url "$object")
    image_url_to_object_map+=("$image_url;$object")
done

# Analyze images
analyze_images "${image_url_to_object_map[@]}"

# Output the location of the CSV file
echo "CSV file created at: $csv_filename" | tee -a "$log_filename"
