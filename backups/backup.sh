#!/usr/bin/env sh

sftp root@128.199.53.111:/home/factorio/saves/funtime.zip /home/user/gstorage/factorio/funtime.zip
rclone sync --gcs-bucket-policy-only /home/user/gstorage encrypt: && date '+%y-%m-%d %H:%M' > $HOME/.config/backups/successful.txt
