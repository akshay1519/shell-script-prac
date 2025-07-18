#!/bin/bash

#6file_change_monitor.sh

read -p "Enter filename to monitor: " filename

if [ ! -f "$filename" ]; then
    echo "File does not exist."
    exit 1
fi

prev_mod=$(stat --format="%y" "$filename")

echo "Monitoring file: $filename"
echo "Initial modification time: $prev_mod"

while true; do
    curr_mod=$(stat --format="%y" "$filename")
    if [[ "$curr_mod" != "$prev_mod" ]]; then
        echo "File '$filename' has been modified!"
        stat --format="Created: %w" "$filename"
        stat --format="Modified: %y" "$filename"
        prev_mod="$curr_mod"
    fi
    sleep 2
done
