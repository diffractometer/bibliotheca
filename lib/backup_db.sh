#!/bin/bash

# Define variables
CONTAINER_NAME="bibliotheca_db"
DB_USER="postgres"
DB_NAME="bibliotheca_development"
DB_PASSWORD="1234"
BACKUP_DIR="/Users/hunterhusar/Code/bibliotheca/db"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Export the database
docker exec -e PGPASSWORD=$DB_PASSWORD $CONTAINER_NAME pg_dump -U $DB_USER $DB_NAME > $BACKUP_FILE

echo "Backup created: $BACKUP_FILE"