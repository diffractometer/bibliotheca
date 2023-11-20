#!/bin/bash

PROMPT="Please list in CSV format the title, genre, and author of each book visible in this image. If a book's title, author, or genre is partly obscured, provide your best guess. The CSV format should strictly be 'title, genre, author' with each book on a new line. Do not include any text other than the CSV-formatted information. Use only these genres: Fantasy, Self-Help, Art, Design, Horror, Science Fiction, Non-Fiction, Mystery, Biography, History, Children’s Literature, Young Adult, Classics, Poetry, Drama, Philosophy, Science, Health & Fitness, Business, Cookbooks, Travel, Humor, Romance, Thriller, Literary Fiction, Graphic Novels, Education, Politics, Cultural Studies, Religion, Sports, Music, Law, Psychology, Technology, True Crime, Crafts & Hobbies, Guide / How-to."

# Bucket and folder details
BUCKET="pureshit-production"
DIRECTORY="bookshelf_cells"

# Function to generate a pre-signed URL for an S3 object
generate_presigned_url() {
    local object_path=$1
    # Generate a pre-signed URL that expires in 300 seconds (5 minutes)
    echo $(aws s3 presign "s3://$BUCKET/$object_path" --expires-in 300)
}

# Function to send image to OpenAI for analysis
analyze_image() {
    local image_url=$1  # URL of the image to analyze

    # Make the API request to OpenAI
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

    echo "$response"
}

# List objects in the S3 bucket and directory
objects=$(aws s3api list-objects --bucket "$BUCKET" --prefix "$DIRECTORY/" --query 'Contents[].Key' --output text)

# Iterate over each object and process it
for object in $objects; do
    # Generate a pre-signed URL for the object
    presigned_url=$(generate_presigned_url "$object")

    # Send the pre-signed URL to OpenAI for analysis
    echo "Analyzing image: $object"
    analysis_response=$(analyze_image "$presigned_url")

    # Extract content from the response
    content=$(echo $analysis_response | jq -r '.choices[0].message.content')

    # Output the content, instead of echoing it, let's actually append to a csv file here,
    # make sure that the csv file is created if it doesn't exist
    # make the name of the csv file include the current date and time, as well as a uuid to make it unique
    # shorten the uuid to 4 characters
    echo -e "$content"
done
