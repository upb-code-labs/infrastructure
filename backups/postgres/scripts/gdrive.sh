#!/bin/sh

# Receive encrypted file name as argument
ENCRYPTED_FILE_NAME=$1

# Push the backup to Google Drive
rclone --config /.config/rclone.conf copyto /var/backups/db/$ENCRYPTED_FILE_NAME gdrive:backups/db/$ENCRYPTED_FILE_NAME

STATUS=$?
exit $STATUS