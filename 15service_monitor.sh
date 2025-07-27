#!/bin/bash

# 15service_monitor.sh
# List of services to monitor
services=("nginx" "apache2" "ssh" "mysql")
log_file="./service_monitor.log"

# Function to log events
log_event() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') $message" >> "$log_file"
}

echo "Service Monitor started. Monitoring: ${services[*]}"
echo "Logging to: $log_file"
echo "Press Ctrl+C to stop."

while true; do
  for svc in "${services[@]}"; do
    # Check if service is active
    echo "Checking status of $svc..."
    systemctl is-active --quiet "$svc"
    status=$?
    echo "Status of $svc: $status"
    if [[ $status -ne 0 ]]; then
      log_event "ALERT: $svc was DOWN. Attempting restart..."
      echo "$svc is down! Restarting..."
      sudo systemctl restart "$svc"
      # Wait briefly after restart, then re-check
      sleep 2
      systemctl is-active --quiet "$svc"
      if [[ $? -eq 0 ]]; then
        log_event "INFO: $svc successfully restarted."
        echo "$svc restarted."
      else
        log_event "ERROR: $svc failed to restart!"
        echo "$svc still down after restart."
      fi
    else
      # Optionally log when a service returns to normal
      # log_event "OK: $svc is running."
      :
    fi
  done
  sleep 10  # Check every 10 seconds
done
