!/bin/bash

# Create a variable for today's date in YYYY-MM-DD format
LOG_DIR="logs_$(date +%F)"
LOG_FILE="${LOG_DIR}/application.log"

echo "--- Starting Daily Log Setup ---"

# 1. Create a directory for today's logs
echo "Creating log directory: ${LOG_DIR}"
mkdir "${LOG_DIR}"

# 2. Create an empty log file
echo "Creating log file: ${LOG_FILE}"
touch "${LOG_FILE}"

# 3. Write a header to the new log file (overwrite)
echo "Log file for $(date)" > "${LOG_FILE}"

# 4. Append a startup message to the log file
echo "INFO: Application starting up." >> "${LOG_FILE}"

echo "--- Log content ---"
# 5. Display the content of the log file
cat "${LOG_FILE}"
echo "-------------------"

echo "Setup complete. To clean up, run: rm -r ${LOG_DIR}"