#!/bin/sh

# Move to the temporary directory
cd /tmp

# Get the current date in format YYYY-MM-DD:HH:MM
DATE=$(date +"%Y-%m-%d:%H:%M")
UNCOMPRESSED_FILE_NAME=$DATE.sql
COMPRESSED_FILE_NAME=$DATE.tar.gz

# Dump the database to a file. Parameters are received as environment variables
pg_dump > ./$UNCOMPRESSED_FILE_NAME
STATUS=$?

if [ $STATUS -ne 0 ]; then
  exit $STATUS
fi

# Compress the file
tar -czf /var/backups/db/$COMPRESSED_FILE_NAME ./$UNCOMPRESSED_FILE_NAME

# Remove the uncompressed file
rm ./$UNCOMPRESSED_FILE_NAME

# Output the name of the file
echo "$COMPRESSED_FILE_NAME"