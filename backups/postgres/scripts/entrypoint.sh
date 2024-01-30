#!/bin/sh

# Run the backup script and save the output
echo "🔵 Running the backup script"
COMPRESSED_FILE_NAME=$(sh ./backup.sh)
BACKUP_STATUS=$?

if [ $BACKUP_STATUS -ne 0 ]; then
  echo "🔴 Failed to backup the database"
  exit $BACKUP_STATUS
fi

# Run the upload script
echo "🔵 Running the upload script"
sh ./gdrive.sh $COMPRESSED_FILE_NAME
UPLOAD_TO_GDRIVE_STATUS=$?

if [ $UPLOAD_TO_GDRIVE_STATUS -ne 0 ]; then
  echo "🔴 Failed to upload the backup to Google Drive"
  exit $UPLOAD_TO_GDRIVE_STATUS
fi

echo "🟢 Backup done and uploaded to Google Drive"