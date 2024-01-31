#!/bin/sh

# Receive compressed file name as argument
COMPRESSED_FILE_NAME=$1
ENCRYPTED_FILE_NAME=$COMPRESSED_FILE_NAME.gpg

# Move to the backups directory
GPG_FOLDER=/etc/gpg
GPG_USERNAME_FILE=$GPG_FOLDER/user_id.txt
GPG_PUBLIC_KEY_FILE=$GPG_FOLDER/public.key
cd $GPG_FOLDER

# Import the public key
gpg --import public.key
IMPORT_STATUS=$?

if [ $IMPORT_STATUS -ne 0 ]; then
  echo "🔴 Failed to import the public key"
  exit $IMPORT_STATUS
fi

# Encrypt the file
gpg --batch --trust-model always --output /var/backups/db/$ENCRYPTED_FILE_NAME --encrypt --recipient $(cat $GPG_USERNAME_FILE) /var/backups/db/$COMPRESSED_FILE_NAME
ENCRYPT_STATUS=$?

if [ $ENCRYPT_STATUS -ne 0 ]; then
  echo "🔴 Failed to encrypt the backup"
  exit $ENCRYPT_STATUS
fi

# Remove the compressed file
rm /var/backups/db/$COMPRESSED_FILE_NAME