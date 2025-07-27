#!/bin/bash

# Get a directory name from the user
read -p "Enter a name for a directory: " DIR_NAME

# --- CHECK IF DIRECTORY EXISTS ---
# '[ -d ... ]' checks if a directory exists.
if [ -d "$DIR_NAME" ]; then
    echo "Directory '${DIR_NAME}' already exists."
else
    echo "Directory '${DIR_NAME}' not found. Creating it now..."
    mkdir "$DIR_NAME"
    echo "Directory created."
fi

# Define the filename and path
FILENAME="${DIR_NAME}/notes.txt"

# --- CHECK IF FILE EXISTS ---
# '[ -f ... ]' checks if a regular file exists.
if [ -f "$FILENAME" ]; then
    echo "File '${FILENAME}' already exists. Appending a new log entry."
    # Append a timestamp if the file exists
    echo "Log entry added on $(date)" >> "$FILENAME"
else
    echo "File '${FILENAME}' not found. Creating it..."
    # Create a new file with a header
    echo "--- My Notes ---" > "$FILENAME"
fi

echo "This is a new note for our file." >> "$FILENAME"
echo "Content has been saved to ${FILENAME}."

# --- READ FROM THE FILE LINE BY LINE ---
echo "" # Print a blank line for spacing
echo "--- Reading content from ${FILENAME} ---"
# Use a while loop to read each line into the 'LINE' variable
LINE_NUMBER=1
while read -r LINE; do
    echo "Line ${LINE_NUMBER}: $LINE"
    ((LINE_NUMBER++))
done < "$FILENAME"
echo "--- End of file ---"

echo ""
echo "Script finished."
