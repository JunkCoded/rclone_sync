# RClone Automation System

This project provides a system for automating **RClone** synchronization.

### Features

RClone is automatically executed in the following cases:

1. **On system startup** — ensures your files are synced immediately after boot.
2. **Every 30 minutes** — periodic synchronization to keep your data up to date.
3. **On system shutdown** — prevents shutdown until synchronization completes, ensuring no data loss.
4. **Waybar integration** — shows the synchronization status in your HyDE Waybar setup.  
   For details, see the [Waybar Integration Guide](waybar).

---

### Notes

This system was originally developed with AI assistance.
While it should work reliably, minor issues may still exist.
I welcome any pull requests, suggestions, or improvements to make it even better!
