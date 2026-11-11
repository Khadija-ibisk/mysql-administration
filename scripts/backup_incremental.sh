#!/bin/bash

# --- Configuration ---
# Days to keep binary logs before purging
DAYS_TO_KEEP=7

# --- Script Execution ---

echo "--- 1. Listing Current Binary Logs ---"
# The 'mysql' command automatically reads credentials from ~/.my.cnf
mysql -e "SHOW BINARY LOGS;"

echo "--- 2. Purging Logs Older than $DAYS_TO_KEEP Days ---"
# This command is clean and relies on the credentials file
mysql -e "PURGE BINARY LOGS BEFORE NOW() - INTERVAL $DAYS_TO_KEEP DAY;"

if [ $? -eq 0 ]; then
    echo "✅ Log purge completed successfully."
else
    echo "❌ Log purge failed. Check your MySQL error log (C:/ProgramData/MySQL/MySQL Server 8.0/Data/DESKTOP-6NEQP0I.err)."
fi

echo "--- 3. Listing Logs After Purge ---"
mysql -e "SHOW BINARY LOGS;"
