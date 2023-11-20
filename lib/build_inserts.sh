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
    if [[ "$line" != "title,genre,author" ]]; then
        # Read the title, genre, and author fields from the CSV
        # Assuming the genre is always present and we're skipping it
        title=$(echo "$line" | cut -d',' -f1)
        author=$(echo "$line" | cut -d',' -f3-)

        # Escape single quotes in SQL
        title=$(echo "$title" | sed "s/'/''/g")
        author=$(echo "$author" | sed "s/'/''/g")

        # Concatenate to the SQL VALUES list
        sql_values+="('$title', '$author', FALSE),"
    fi
done < <(tail -n +2 "$filename")

# Remove the trailing comma from the SQL VALUES list
sql_values=${sql_values%,}

# Write the SQL INSERT statement to the SQL file
echo "INSERT INTO Books (title, author, verified) VALUES $sql_values;" > "$sql_filename"

echo "The SQL INSERT statements have been generated and saved as: $sql_filename"
