#!/bin/bash

# 1timer_announcer.sh
announce_time() {
    echo "Good morning! Aice."

    day=$(date +%A)
    date=$(date +%d)
    month=$(date +%B)
    year=$(date +%Y)
    time=$(date +%H:%M)
    am_pm=$(date +%p)

    echo "It's $day, $date $month $year $time $am_pm."
}

while true; do
    announce_time
    sleep 60  
done