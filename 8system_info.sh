!/bin/bash

# 8system_info.sh

system_info() {
    echo "System Information:"
    echo "-------------------"
    
    echo "Operating System: $(uname -s)"
    echo "Kernel Version: $(uname -r)"
    echo "Hostname: $(hostname)"
    echo "Current User: $(whoami)"

    echo "-------------------"
}


while true; do
    system_info
    sleep 5
done