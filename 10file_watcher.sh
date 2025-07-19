#!/bin/bash

# 10file_watcher.sh

get_user_input() {
    read -e -p "Enter the file path to watch for changes: " file_path
    echo "Watching for changes in: $file_path"
}


watch_file() {
    local file_path="$1"
    if [[ ! -f "$file_path" ]]; then
        echo "File does not exist: $file_path"
        exit 1
    fi

    LAST_MODIFIED=$(stat -c %Y "$file_path")

    while true; do
        sleep 1
        CURRENT_MODIFIED=$(stat -c %Y "$file_path")
        if [[ "$CURRENT_MODIFIED" != "$LAST_MODIFIED" ]]; then
            echo "The file '$file_path' was modified at $(date -d @$CURRENT_MODIFIED)"
            LAST_MODIFIED="$CURRENT_MODIFIED"
        fi
    done
}

get_user_input
watch_file "$file_path"