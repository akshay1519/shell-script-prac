#!/bin/bash

#2uptime_monitor.sh

announce_uptime(){
    up_time=$(uptime)
    echo "Current uptime: $up_time"
}

while true; do
    announce_uptime
    sleep 5
done
