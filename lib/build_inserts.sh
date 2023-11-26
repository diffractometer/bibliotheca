#!/bin/bash

# Prompt for the CSV filename
echo "Enter the CSV filename (e.g., books.csv):"
read -r filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Create a new filename with "inserts.sql" appended to the original file name, excluding extension
sql_filename="${filename%.*}_inserts.sql"

# Initialize an empty value for the SQL VALUES list
sql_values=""

# Read the CSV file and generate SQL INSERT values
while IFS= read -r line; do
    # Skip the header line
    if [[ "$line" != "title,author,cover_image_s3_url" ]]; then
        # Read the title and author fields from the CSV
        title=$(echo "$line" | cut -d',' -f1)
        author=$(echo "$line" | cut -d',' -f2)
        # The S3 URL is the third field in the CSV
        cover_image_s3_url=$(echo "$line" | cut -d',' -f3)

        # Remove whitespace in front of the author and S3 URL
        author=$(echo "$author" | sed -e 's/^[[:space:]]*//')
        cover_image_s3_url=$(echo "$cover_image_s3_url" | sed -e 's/^[[:space:]]*//')

        # Escape single quotes in SQL
        title=$(echo "$title" | sed "s/'/''/g")
        author=$(echo "$author" | sed "s/'/''/g")
        cover_image_s3_url=$(echo "$cover_image_s3_url" | sed "s/'/''/g")

        # Concatenate to the SQL VALUES list
        sql_values+="(uuid_generate_v4(), '$title', '$author', FALSE, NOW(), NOW(), '$cover_image_s3_url'),"
    fi
done < <(tail -n +2 "$filename")

# Remove the trailing comma from the SQL VALUES list
sql_values=${sql_values%,}

# Write the SQL INSERT statement to the SQL file
echo "INSERT INTO Books (id, title, author, verified, created_at, updated_at, cover_image_s3_url) VALUES $sql_values;" > "$sql_filename"

echo "The SQL INSERT statements have been generated and saved as: $sql_filename"
