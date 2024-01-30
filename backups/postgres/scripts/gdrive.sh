#!/bin/sh

# Receive compressed file name as argument
COMPRESSED_FILE_NAME=$1

# Push the backup to Google Drive
rclone --config /.config/rclone.conf copyto /var/backups/db/$COMPRESSED_FILE_NAME gdrive:backups/db/$COMPRESSED_FILE_NAME

STATUS=$?
exit $STATUS