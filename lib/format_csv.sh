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
    # Extract the title, genre, and author fields using cut and sed to handle fields with commas
    title=$(echo "$line" | cut -d',' -f1)
    genre=$(echo "$line" | cut -d',' -f2)
    author=$(echo "$line" | cut -d',' -f3- | sed 's/, /|/g')

    # Write the formatted line to the new CSV file
    echo "$title,$genre,$author" >> "$formatted_filename"
done < "$filename"

echo "The CSV file has been formatted and saved as: $formatted_filename"
