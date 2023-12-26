#!/bin/bash

# Variables
CONTAINER_NAME="bibliotheca_db"
DB_USER="postgres"
DB_PASSWORD="1234"
DB_NAME="bibliotheca_development"
BACKUP_DIR="/Users/hunterhusar/Code/bibliotheca/db"

# List backups
echo "Available backups:"
select BACKUP_FILE in $BACKUP_DIR/*; do
  test -n "$BACKUP_FILE" && break
  echo ">>> Invalid Selection"
done

# Drop and recreate DB
docker exec -e PGPASSWORD=$DB_PASSWORD $CONTAINER_NAME psql -U $DB_USER -c "DROP DATABASE IF EXISTS $DB_NAME; CREATE DATABASE $DB_NAME;"

# Restore DB
cat "$BACKUP_FILE" | docker exec -i -e PGPASSWORD=$DB_PASSWORD $CONTAINER_NAME psql -U $DB_USER $DB_NAME

echo "Restored from: $BACKUP_FILE"
