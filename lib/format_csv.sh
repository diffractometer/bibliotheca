#!/bin/bash

# Prompt for the CSV filename
echo "Enter the CSV filename (e.g., src/test/resources/csv/books_2023-11-19_18-15-07_A0FD.csv):"
read -r filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Create a new filename with "formatted" appended
formatted_filename="${filename%.csv}_formatted.csv"

# Read the original CSV line by line and process it
while IFS= read -r line; do
    # Extract the title and author fields assuming they are the first two CSV fields
    title=$(echo "$line" | cut -d',' -f1)
    author=$(echo "$line" | cut -d',' -f2)
    # The S3 URL is assumed to be the third field
    s3_url=$(echo "$line" | cut -d',' -f3)

    # Replace any commas within the author field with a pipe
    author=$(echo "$author" | sed 's/, /|/g')

    # Write the formatted line to the new CSV file
    echo "$title,$author,$s3_url" >> "$formatted_filename"
done < "$filename"

echo "The CSV file has been formatted and saved as: $formatted_filename"
