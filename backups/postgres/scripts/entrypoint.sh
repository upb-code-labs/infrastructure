#!/bin/sh

# Run the backup script and save the output
COMPRESSED_FILE_NAME=$(sh ./backup.sh)
STATUS=$?

if [ $STATUS -ne 0 ]; then
  echo "Failed to backup the database"
  exit 1
fi

# Run the upload script
sh ./gdrive.sh $COMPRESSED_FILE_NAME
STATUS=$?

if [ $STATUS -ne 0 ]; then
  echo "Failed to upload the backup to Google Drive"
  exit 1
fi