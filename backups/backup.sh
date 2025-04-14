#!/usr/bin/env sh

rclone sync --gcs-bucket-policy-only /home/user/gstorage encrypt: && date '+%y-%m-%d %H:%M' > $HOME/.config/backups/successful.txt
