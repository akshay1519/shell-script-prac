#!/bin/bash

# 13account_permission.sh

# Get a list of regular users (UIDs 1000-65533)
users=$(awk -F: '$3>=1000 && $3<65534 {print $1}' /etc/passwd)

echo "===== List of Users and Their Last Login ====="
for user in $users; do
    last_login=$(lastlog -u "$user" | awk 'NR==2 {print $4, $5, $6, $7, $8}')
    echo "$user - Last login: $last_login"
done

echo
echo "===== World-Writable Files in /etc ====="
# Find world-writable files in /etc
find /etc -type f \( -perm -g=w -o -perm -o=w \) 2>/dev/null

echo
echo "===== World-Writable Files in /var ====="
# Find world-writable files in /var
find /var -type f \( -perm -g=w -o -perm -o=w \) 2>/dev/null
