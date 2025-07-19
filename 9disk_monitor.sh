#!/bin/bash

# 9disk_monitor.sh

PARTITION="/"

FREE_SPACE=$(df -h "$PARTITION" | awk 'NR==2 {print $4}' | sed 's/G/ GB/' | sed 's/M/ MB/' | sed 's/K/ KB/')

echo "Free space on $PARTITION: $FREE_SPACE"

