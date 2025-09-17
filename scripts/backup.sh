#!/bin/bash

SOURCE_DIR="/path/to/local/directory"    
REMOTE_USER="user"
REMOTE_HOST="10.145.4.32"
REMOTE_DIR="/data/backup"
LOG_FILE="/var/log/backup.log"

DATE=$(date '+%Y-%m-%d %H:%M:%S')


echo "[$DATE] Starting backup of $SOURCE_DIR to $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" | tee -a "$LOG_FILE"

rsync -avz --delete "$SOURCE_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE" 2>&1
STATUS=$?

if [ $STATUS -eq 0 ]; then
    echo "[$DATE] Backup completed successfully." | tee -a "$LOG_FILE"
else
    echo "[$DATE] Backup failed with exit code $STATUS." | tee -a "$LOG_FILE"
fi
