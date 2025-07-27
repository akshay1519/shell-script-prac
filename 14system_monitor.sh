#!/bin/bash

#14system_monitor.sh

# Default refresh rate in seconds
refresh_rate=10

# Function to draw a simple bar for percentage value (0-100)
draw_bar() {
  local percent=$1
  local width=30
  local filled=$(( percent * width / 100 ))
  local empty=$(( width - filled ))
  printf "["
  for ((i=0; i<filled; i++)); do printf "#"; done
  for ((i=0; i<empty; i++)); do printf " "; done
  printf "] %3d%%" "$percent"
}

while true; do
  clear

  # CPU usage (using top)
  cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}')
  cpu_usage=$((100 - ${cpu_idle%.*}))

  # Memory usage (using free)
  mem_used=$(free | awk '/Mem:/ {print $3}')
  mem_total=$(free | awk '/Mem:/ {print $2}')
  mem_usage=$((mem_used * 100 / mem_total))

  # Network usage (bytes sent and received since boot)top -bn1
  
  net_info=$(awk '/^ *eth|^ *enp|^ *wlp/ {print $1, $2, $10}' /proc/net/dev | head -n1)
  iface=$(echo $net_info | awk '{print $1}')
  net_rx=$(echo $net_info | awk '{print $2}')
  net_tx=$(echo $net_info | awk '{print $3}')

  # Convert bytes to KB
  net_rx_kb=$((net_rx / 1024))
  net_tx_kb=$((net_tx / 1024))

  echo "Simple Shell Resource Monitor"
  echo "Refresh rate: $refresh_rate sec (Press Ctrl+C to quit)"
  echo

  echo -n "CPU Usage:    "
  draw_bar $cpu_usage
  echo

  echo -n "Memory Usage: "
  draw_bar $mem_usage
  echo

  echo "Network ($iface): Received ${net_rx_kb}kB, Transmitted ${net_tx_kb}kB"

  sleep $refresh_rate
done
