#!/bin/bash

# 11network_health.sh

Hosts=("google.com" "github.com" "stackoverflow.com" "127.0.0")
Email="admin@example.com"
LogFile="/var/log/network_health.log"

touch "$LogFile"

check_host() {
    local host="$1"
    local Failure=0
    if ! dpkg -s mailutils >/dev/null 2>&1; then
        echo "mailutils not found. Please install it to enable email notifications."
        exit 1
    fi

    if ! ping -c 1 "$host" &> /dev/null; then
       echo "$(date '+%Y-%m-%d %H:%M:%S') | FAILURE | $host unavailable" >> $LogFile
       echo "$host is down at $(date)" | mail -s "ALERT: $host is DOWN" $Email
       Failure=1
    else
       echo "$(date '+%Y-%m-%d %H:%M:%S') | SUCCESS | $host is reachable" >> $LogFile
    fi
    
}

while true; do
    for host in "${Hosts[@]}"; do
        check_host "$host"
    done
    sleep 60  # Check every 60 seconds
done