#!/bin/bash

LOG_FILE="./user_management.log"
MIN_PASS_LENGTH=6

# Logging function
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

# Function to add a new user
add_user() {
    read -p "Enter username to add: " username

    if id "$username" &>/dev/null; then
        echo "User $username already exists."
        return
    fi

    read -sp "Enter password for $username (min $MIN_PASS_LENGTH chars): " password
    echo
    if [[ ${#password} -lt $MIN_PASS_LENGTH ]]; then
        echo "Password too short. Aborting."
        return
    fi

    # Add user with home directory and bash shell
    useradd -m -s /bin/bash "$username"
    if [[ $? -ne 0 ]]; then
        echo "Failed to add user $username."
        return
    fi

    # Set user password
    echo "$username:$password" | chpasswd
    if [[ $? -ne 0 ]]; then
        echo "Failed to set password for $username."
        return
    fi

    # Enforce password change on first login
    passwd -e "$username"

    echo "User $username added successfully."
    log_action "Added user $username"
}

# Function to modify password of existing user
modify_password() {
    read -p "Enter username to change password: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi

    read -sp "Enter new password (min $MIN_PASS_LENGTH chars): " password
    echo
    if [[ ${#password} -lt $MIN_PASS_LENGTH ]]; then
        echo "Password too short. Aborting."
        return
    fi

    echo "$username:$password" | chpasswd
    if [[ $? -eq 0 ]]; then
        passwd -e "$username"
        echo "Password changed for $username."
        log_action "Changed password for $username"
    else
        echo "Failed to change password for $username."
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi

    read -p "Delete home directory too? (y/n): " delete_home
    if [[ "$delete_home" =~ ^[Yy]$ ]]; then
        userdel -r "$username"
    else
        userdel "$username"
    fi

    if [[ $? -eq 0 ]]; then
        echo "User $username deleted."
        log_action "Deleted user $username"
    else
        echo "Failed to delete user $username."
    fi
}

# Function to list system users (UID >= 1000)
list_users() {
    echo "System users:"
    awk -F: '$3 >= 1000 && $1 != "nobody" { print $1 }' /etc/passwd
}

# Function to list groups (GID >= 1000)
list_groups() {
    echo "System groups (GID >= 1000):"
    awk -F: '$3 >= 1000 { print $1 }' /etc/group
}

# Function to add a user to a group
add_user_to_group() {
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi

    read -p "Enter group to add $username to: " groupname
    # Create group if it doesn't exist
    if ! getent group "$groupname" &>/dev/null; then
        groupadd "$groupname"
        echo "Group $groupname created."
        log_action "Created group $groupname"
    fi

    usermod -aG "$groupname" "$username"
    if [[ $? -eq 0 ]]; then
        echo "User $username added to group $groupname."
        log_action "Added user $username to group $groupname"
    else
        echo "Failed to add user $username to group $groupname."
    fi
}

# Function to remove user from a group
remove_user_from_group() {
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi

    read -p "Enter group to remove $username from: " groupname
    if ! getent group "$groupname" &>/dev/null; then
        echo "Group $groupname does not exist."
        return
    fi

    # Remove user from group by reassigning all groups except this one
    current_groups=$(id -nG "$username" | sed "s/$groupname//g" | xargs)
    usermod -G "$current_groups" "$username"
    if [[ $? -eq 0 ]]; then
        echo "User $username removed from group $groupname."
        log_action "Removed user $username from group $groupname"
    else
        echo "Failed to remove user $username from group $groupname."
    fi
}

# Main menu loop
while true; do
    echo ""
    echo "User Account Management Menu"
    echo "1) Add User"
    echo "2) Modify User Password"
    echo "3) Delete User"
    echo "4) List Users"
    echo "5) Add User to Group"
    echo "6) Remove User from Group"
    echo "7) List Groups"
    echo "8) Exit"
    read -p "Choose an option [1-8]: " choice

    case "$choice" in
        1) add_user ;;
        2) modify_password ;;
        3) delete_user ;;
        4) list_users ;;
        5) add_user_to_group ;;
        6) remove_user_from_group ;;
        7) list_groups ;;
        8) echo "Exiting."; exit 0 ;;
        *) echo "Invalid option. Try again." ;;
    esac
done
