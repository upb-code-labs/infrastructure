# Folder backup utility

This is a simple docker image that compress a folder using `tar` and then upload the backup to a Google Drive folder using `rclone`.

## Usage

### Prerequisites

1. You need to configure `rclone` to access your Google Drive account. Please, refer to the [rclone docs](https://rclone.org/drive/) for more information. This step may require you to create a new project in the your GCP account and enable the Google Drive API as shown in the [rclone docs](https://rclone.org/drive/#making-your-own-client-id). Please, note the following:

   - The [script](./scripts/entrypoint.sh) expects a remote named `gdrive` to be configured in `rclone`. You can change the name of the remote in the script and build your own image or set the remote name as `gdrive` when configuring `rclone`.

   - After configuring `rclone`, you need to save the configuration file somewhere in the node that will run the backup as you will need to mount it to the container.

### Docker

If you want to run the backup using the standalone container, you can use the following command:

```bash
docker run \
    # So that the container can access the rclone configuration
    -v /path/to/rclone.conf:/.config/rclone.conf:ro \
    # So that the container can access the folder to be backed up
    -v /path/to/folder:/var/codelabs/archives:ro \
    # So that the backup can be also saved in the host
    -v /path/to/backups:/var/codelabs/backups/archives \
    pedrochaparroupb/directory-rclone-backup-utility:0.1.0
```