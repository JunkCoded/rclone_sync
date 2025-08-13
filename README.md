# RClone Automation System

This project provides a system for automating **RClone** synchronization.

### Features

RClone is automatically executed in the following cases:

1. **On system startup** — ensures your files are synced immediately after boot.
2. **Every 30 minutes** — periodic synchronization to keep your data up to date.
3. **On system shutdown** — prevents shutdown until synchronization completes, ensuring no data loss.
4. **Waybar integration** — shows the synchronization status in your HyDE Waybar setup.

---

### Waybar Integration

This system includes a Waybar module to display the current synchronization status with four states:

* **Synced** — displayed when the timer is running normally.
* **Synchronizing** — displayed while synchronization is in progress.
* **Error** — displayed if the last synchronization failed.
* **Disabled** — displayed if synchronization is turned off.

#### Click Actions

* **Left-click**: Trigger manual synchronization immediately.
* **Right-click**: Toggle the synchronization timer and shutdown service on or off.

#### Visuals

* Optional color coding for clarity: e.g., green for synced, blue for in progress, red for error, gray for disabled.
* Optional animations for the synchronizing state for better visual feedback.

#### Installation

1. Copy the Waybar script/module to your HyDE configuration folder:

```bash
mkdir -p ~/.config/waybar/modules/rclone_sync
cp path/to/rclone_sync_waybar.sh ~/.config/waybar/modules/rclone_sync/
```

2. Make sure the script is executable:

```bash
chmod +x ~/.config/waybar/modules/rclone_sync/rclone_sync_waybar.sh
```

3. Add the module to your Waybar configuration (`~/.config/waybar/config`):

```json
// can change to any group
"modules-right": ["custom/rclone_sync"],

"custom/rclone_sync": {
    "return-type": "json",
    "exec": "~/.config/waybar/modules/rclone_sync/rclone_sync_waybar.sh status",
    "interval": 5,
    "signal": 8,
    "tooltip": true,
    "on-click": "~/.config/waybar/modules/rclone_sync/rclone_sync_waybar.sh sync",
    "on-click-right": "~/.config/waybar/modules/rclone_sync/rclone_sync_waybar.sh toggle-sync"
}
```

4. Add style (`~/.config/waybar/user-style.css` or `~/.config/waybar/style.css`)

```css
/* #custom-rclone_sync.synced   { color: #5cb85c; } */ 
#custom-rclone_sync.syncing  { color: #f0ad4e; } 
#custom-rclone_sync.error    { color: #d9534f; }
#custom-rclone_sync.disabled { color: #9e9e9e; }
```

5. Restart Waybar to apply changes:

```bash
pkill waybar && waybar &
```

After this, the Waybar icon will automatically reflect the synchronization status and allow interactive control.

---

### Notes

This system was originally developed with AI assistance.
While it should work reliably, minor issues may still exist.
I welcome any pull requests, suggestions, or improvements to make it even better!
