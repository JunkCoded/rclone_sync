#!/bin/bash

# sync_script.sh
# Runs rclone bisync. Use for manual run or in crontab.
# Usage: bash sync_script.sh [resync/dry]

set -euo pipefail

LOCAL_USER="apc"
LOCAL_DIR="/home/$LOCAL_USER/SyncArea"
REMOTE_NAME="drive"
REMOTE_PATH="SyncArea"
LOCAL_BACKUP_DIR="/home/$LOCAL_USER/SyncArea-backup"
REMOTE_BACKUP_DIR="SyncArea-backup"
LOG_FILE="/home/$LOCAL_USER/.SyncArea.log"

# Base command
COMMAND="rclone bisync \"$LOCAL_DIR\" \"${REMOTE_NAME}:${REMOTE_PATH}\" \
    --backup-dir1 \"$LOCAL_BACKUP_DIR\" \
    --backup-dir2 \"${REMOTE_NAME}:${REMOTE_BACKUP_DIR}\" \
    --conflict-resolve newer \
    --conflict-loser pathname \
    --resilient \
    --recover \
    --check-sync true \
    --verbose \
    --log-file \"$LOG_FILE\""

# Add resync if specified
if [ "${1:-}" = "resync" ]; then
    COMMAND="$COMMAND --resync"
fi

if [ "${1:-}" = "dry" ]; then
    COMMAND="$COMMAND --dry-run"
fi

echo "Running sync..."
eval "$COMMAND" || {
    echo "Sync error. Check log: $LOG_FILE"
    exit 1
}
echo "Sync completed."
