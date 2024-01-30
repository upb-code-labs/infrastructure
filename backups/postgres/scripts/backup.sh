#!/bin/sh

# Get the current date in format YYYY-MM-DD:HH:MM
DATE=$(date +"%Y-%m-%d:%H:%M")
echo "Starting backup at $DATE"

UNCOMPRESSED_FILE_NAME=$DATE.sql
COMPRESSED_FILE_NAME=$DATE.tar.gz

# Dump the database to a file. Note that parameters are received as environment variables
pg_dump > /var/backups/db/$UNCOMPRESSED_FILE_NAME
STATUS=$?

if [ $STATUS -ne 0 ]; then
  exit $STATUS
fi

# Compress the file
tar -czf /var/backups/db/$COMPRESSED_FILE_NAME /var/backups/db/$UNCOMPRESSED_FILE_NAME

# Remove the uncompressed file
rm /var/backups/db/$UNCOMPRESSED_FILE_NAME

# Output the name of the file
echo $COMPRESSED_FILE_NAME