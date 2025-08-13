#!/usr/bin/env bash
set -euo pipefail

# Define source files
USER_SERVICE="rclone_sync.service"
USER_TIMER="rclone_sync.timer"
SHUTDOWN_SERVICE="rclone_sync_shutdown.service"
START_SCRIPT="start_sync.sh"
ENV_FILE=".env"

# Define target directories
USER_SYSTEMD_DIR="$HOME/.config/systemd/user"
ROOT_SYSTEMD_DIR="/etc/systemd/system"
SYNC_CFG_DIR="$HOME/.rclone_sync"

echo "=== Copying Rclone Sync Services and Sync Script ==="

# Create directories if they don't exist
mkdir -p "$USER_SYSTEMD_DIR"
mkdir -p "$SYNC_CFG_DIR"

# Copy user service and timer
echo "Copying user service and timer..."
cp -v "$USER_SERVICE" "$USER_SYSTEMD_DIR/"
cp -v "$USER_TIMER" "$USER_SYSTEMD_DIR/"

# Copy shutdown service to root (requires sudo)
echo "Copying shutdown service to root systemd directory..."
sudo cp -v "$SHUTDOWN_SERVICE" "$ROOT_SYSTEMD_DIR/"

# Copy start_sync.sh script
echo "Copying start_sync.sh script..."
cp -v "$START_SCRIPT" "$SYNC_CFG_DIR/"

# Copy env
echo "Copying env..."
cp -v "$ENV_FILE" "$SYNC_CFG_DIR/"
#
# Make sure start_sync.sh is executable
chmod +x "$SYNC_CFG_DIR/start_sync.sh"

echo "Copying done!"
