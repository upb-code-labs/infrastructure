#!/bin/sh

# 1. Compress the static files directory
BACKUPS_PATH=/var/codelabs/backups
echo "🔵 Compressing the static files directory"

## Move to the static files directory
cd /var/codelabs

## Get the current date in format YYYY-MM-DD:HH:MM
DATE=$(date +"%Y-%m-%d:%H:%M")
UNCOMPRESSED_FOLDER_NAME="archives" # Mount point
COMPRESSED_FOLDER_NAME=$DATE.tar.gz

## Compress the folder
# tar -czf ./$COMPRESSED_FOLDER_NAME ./$UNCOMPRESSED_FOLDER_NAME
tar -czf $BACKUPS_PATH/$COMPRESSED_FOLDER_NAME ./$UNCOMPRESSED_FOLDER_NAME

# 2. Upload the compressed directory to Google Drive
echo "🔵 Uploading the compressed directory to Google Drive"

## Push the backup to Google Drive
rclone --config /.config/rclone.conf copyto $BACKUPS_PATH/$COMPRESSED_FOLDER_NAME gdrive:backups/archives/$COMPRESSED_FOLDER_NAME

echo "🟢 Backup done and uploaded to Google Drive"