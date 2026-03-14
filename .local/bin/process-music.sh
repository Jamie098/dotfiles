#!/bin/bash

COMPLETED_DIR="/mnt/storage/music/downloads/completed"
CLEAN_DIR="/mnt/storage/music/clean"
QUARANTINE_DIR="/mnt/storage/music/quarantine"
LOG_DIR="/mnt/storage/music/logs"
STAGING_DIR="/mnt/storage/music/staging"

# Create directories if they don't exist
mkdir -p "$STAGING_DIR" "$CLEAN_DIR" "$LOG_DIR" "$QUARANTINE_DIR"

# Check if there are files to process
if [ ! "$(ls -A $COMPLETED_DIR 2>/dev/null)" ]; then
    echo "No new downloads to process."
    exit 0
fi

echo "=== Processing music downloads $(date) ==="

# Step 1: Scan for malware
SCAN_LOG="$LOG_DIR/scan-$(date +%Y%m%d-%H%M%S).log"
echo "🔍 Scanning for malware..."
clamscan -r --move="$QUARANTINE_DIR" --log="$SCAN_LOG" "$COMPLETED_DIR"

# Report quarantined files
if [ "$(ls -A $QUARANTINE_DIR 2>/dev/null)" ]; then
    echo "⚠️  WARNING: Infected files moved to quarantine!"
    ls -la "$QUARANTINE_DIR"
    echo ""
fi

# Step 2: Move clean files to staging
echo "📁 Moving clean files to staging area..."
if [ "$(ls -A $COMPLETED_DIR 2>/dev/null)" ]; then
    mv "$COMPLETED_DIR"/* "$STAGING_DIR"/
    echo "✅ Files moved to staging: $STAGING_DIR"
    echo ""
    echo "🎵 Ready for Picard processing!"
    echo "   1. Open Picard: picard"
    echo "   2. Add files from: $STAGING_DIR"
    echo "   3. Process and save to: $CLEAN_DIR"
    echo ""
else
    echo "❌ No clean files to process (all may have been quarantined)"
    exit 1
fi

echo "📊 Scan log: $SCAN_LOG"
echo "🗂️  Staging directory: $STAGING_DIR"
echo "🎯 Target directory: $CLEAN_DIR"
