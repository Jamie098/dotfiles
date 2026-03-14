#!/bin/bash

# Get the actual user
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)
MUSIC_DIR="$REAL_HOME/Music"
MOUNT_POINT="$REAL_HOME/ipod_mount"
IPOD_DEVICE="/dev/sdb2"

echo "Syncing music to iPod..."
echo "Using music from: $MUSIC_DIR"

# Create mount point if it doesn't exist
mkdir -p "$MOUNT_POINT"

# Mount iPod
echo "Mounting iPod..."
mount "$IPOD_DEVICE" "$MOUNT_POINT"

if [ $? -ne 0 ]; then
    echo "Failed to mount iPod. Is it connected?"
    exit 1
fi

# Show current iPod music
echo "Current music on iPod:"
ls "$MOUNT_POINT/Music/"
echo ""

# Ask what to sync
echo "Choose sync option:"
echo "1) Sync only new/changed music (recommended)"
echo "2) Replace all music"
echo "3) Sync specific artist/album"
echo "4) Just mount (manual copy)"
read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo "Syncing new/changed music only..."
        # Use rsync with update flag to only copy newer files
        rsync -rlptv --update --no-perms --no-owner --no-group --progress "$MUSIC_DIR/" "$MOUNT_POINT/Music/"
        ;;
    2)
        echo "Replacing all music..."
        rm -rf "$MOUNT_POINT/Music"/*
        cp -r "$MUSIC_DIR"/* "$MOUNT_POINT/Music/"
        ;;
    3)
        echo "Available artists/albums:"
        ls "$MUSIC_DIR/Albums/" 2>/dev/null || echo "No albums found"
        read -p "Enter folder name to sync: " folder
        if [ -d "$MUSIC_DIR/Albums/$folder" ]; then
            cp -r "$MUSIC_DIR/Albums/$folder" "$MOUNT_POINT/Music/"
        else
            echo "Folder not found"
        fi
        ;;
    4)
        echo "iPod mounted at: $MOUNT_POINT"
        echo "Manually copy files, then press Enter to unmount..."
        read
        ;;
esac

echo "Sync complete!"
echo "Safely unmounting iPod..."
umount "$MOUNT_POINT"
echo "iPod ready to use!"
