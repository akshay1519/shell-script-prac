#!/bin/bash

# 19traffic_monitor.sh

# Configuration
INTERFACE="eth0"                         # Change to your network interface
THRESHOLD_KB=100000                     # Traffic threshold in KB (example: 100000 KB = 100 MB)
STATE_FILE="/tmp/traffic_monitor_state"
ADMIN_EMAIL="admin@example.com"

# Get current RX bytes
rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes 2>/dev/null)
if [[ -z "$rx_bytes" ]]; then
  echo "Error: Interface $INTERFACE not found."
  exit 1
fi

# Load previous RX bytes and consecutive count
prev_rx_bytes=0
count=0
if [[ -f $STATE_FILE ]]; then
  read prev_rx_bytes count < $STATE_FILE
fi

# Calculate bytes received since last check
if [[ $prev_rx_bytes -eq 0 ]]; then
  # First run, just save and exit (no previous data)
  echo "$rx_bytes 0" > "$STATE_FILE"
  exit 0
fi

bytes_diff=$(( rx_bytes - prev_rx_bytes ))
# Prevent negative if interface reset
if (( bytes_diff < 0 )); then
  bytes_diff=$rx_bytes
fi

# Convert to KB
kb_diff=$(( bytes_diff / 1024 ))

# Check threshold and update count
if (( kb_diff > THRESHOLD_KB )); then
  count=$((count + 1))
else
  count=0
fi

# Save current stats
echo "$rx_bytes $count" > "$STATE_FILE"

# Alert if threshold exceeded 3 consecutive times
if (( count >= 3 )); then
  SUBJECT="Alert: High incoming traffic on $INTERFACE"
  BODY="Incoming traffic on interface $INTERFACE has exceeded $THRESHOLD_KB KB for 3 consecutive checks.
Current traffic: ${kb_diff} KB (last 5 minutes approx).
Please investigate."

  # Send email (ensure 'mail' or 'mailx' is installed and configured)
  echo "$BODY" | mail -s "$SUBJECT" "$ADMIN_EMAIL"

  # Reset counter to avoid repeated spam
  echo "$rx_bytes 0" > "$STATE_FILE"
fi
