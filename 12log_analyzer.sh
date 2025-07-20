#!/bin/bash

#12log_analyzer.sh

filepath="$(dirname "$0")/sample.log"

# Debug: Check if file exists and is readable
echo "Debug: Checking file path: $filepath"
if [ -f "$filepath" ]; then
    echo "Debug: File exists"
    echo "Debug: File size: $(wc -l < "$filepath") lines"
else
    echo "Debug: File does not exist!"
    exit 1
fi

most_frequent_ip() {
    awk '{print $1}' "$filepath" | sort | uniq -c | sort -nr | head -n 5
}

error_count() {
    echo "Debug: Counting error 500 occurrences: $(grep -c '500' "$filepath")"
    echo -e " Error Messages:\n$(grep '500' "$filepath")"
    echo "Debug: Counting error 404 occurrences: $(grep -c '404' "$filepath")"
    echo -e " Error Messages:\n$(grep '404' "$filepath")"   
}

echo "=== Most Frequent IP Addresses ==="
most_frequent_ip

echo "=== Error Count (500) ==="
error_count