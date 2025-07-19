#!/bin/bash

# 9disk_monitor.sh

PARTITION="/"

FREE_SPACE=$(df -h "$PARTITION" | awk 'NR==2 {print $4}' | sed 's/Gi/ GB/' | sed 's/Mi/ MB/' | sed 's/Ki/ KB/')

echo "Free space on $PARTITION: $FREE_SPACE"

