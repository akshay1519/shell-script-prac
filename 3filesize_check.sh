get_user_input() {
    read -e -p "Enter the file path: " file_path
}

get_file_size() {
    local file_path="$1"
    if [[ -z "$file_path" ]]; then
        echo "No file path provided as parameter."
        return 1
    fi
    if [[ "${file_path: -1}" == "/" ]]; then
        file_path="${file_path%/}"
    fi
    if [[ ! -e "$file_path" ]]; then
        echo "File does not exist: $file_path"
        return 1
    fi
    if [[ -d "$file_path" ]]; then
        echo "The provided path is a directory, not a file: $file_path"
        return 1
    fi
    echo "File path provided: $file_path"
    echo "File size: $(du -sh "$file_path" 2>/dev/null | awk '{print $1}' | sed -e 's/B$/ Bytes/' -e 's/M$/ MB/' -e 's/K$/ KB/' -e 's/G$/ GB/')"
}

get_user_input
get_file_size "$file_path"