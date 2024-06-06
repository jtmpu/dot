#/usr/bin/env sh

status="$HOME/.config/backups/successful.txt"
if [ -f $status ]; then
    bdate=$(cat $status)
    # Extract only time?
    echo $bdate
else
    echo N/A
fi
