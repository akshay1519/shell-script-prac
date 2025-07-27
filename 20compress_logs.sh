#!/bin/bash

# 20compress_logs.sh

LOG_DIR="/var/log"
REPORT_FILE="/tmp/log_compression_report.txt"
ADMIN_EMAIL="admin@example.com"

echo "Log Compression Report - $(date)" > "$REPORT_FILE"
echo "------------------------------------" >> "$REPORT_FILE"

# Find files older than 1 day and not .gz compressed (exclude directories)
files_to_compress=$(find "$LOG_DIR" -type f ! -name "*.gz" -mtime +0)

success_count=0
fail_count=0

for file in $files_to_compress; do
  if gzip "$file" 2>/tmp/gzip_error.log; then
    echo "SUCCESS: Compressed $file" >> "$REPORT_FILE"
    ((success_count++))
  else
    echo "FAILURE: Could not compress $file" >> "$REPORT_FILE"
    cat /tmp/gzip_error.log >> "$REPORT_FILE"
    ((fail_count++))
  fi
done

echo "" >> "$REPORT_FILE"

# Delete compressed logs older than 30 days
old_compressed=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30)
for oldfile in $old_compressed; do
  if rm -f "$oldfile"; then
    echo "Deleted old compressed log: $oldfile" >> "$REPORT_FILE"
  else
    echo "Failed to delete old compressed log: $oldfile" >> "$REPORT_FILE"
  fi
done

# Summary
echo "" >> "$REPORT_FILE"
echo "Summary:" >> "$REPORT_FILE"
echo "Files compressed successfully: $success_count" >> "$REPORT_FILE"
echo "Files failed to compress: $fail_count" >> "$REPORT_FILE"

# Email the report
mail -s "Daily Log Compression Report" "$ADMIN_EMAIL" < "$REPORT_FILE"

# Cleanup
rm -f /tmp/gzip_error.log
rm -f "$REPORT_FILE"
