#!/bin/bash

echo "Database Backup and Restore Tool"
echo

read -p "Choose database type (mysql/pgsql): " dbtype
if [[ "$dbtype" != "mysql" && "$dbtype" != "pgsql" ]]; then
    echo "Unsupported database type. Exiting."
    exit 1
fi

read -p "Backup or restore? (b/r): " action
if [[ "$action" != "b" && "$action" != "r" ]]; then
    echo "Invalid action. Exiting."
    exit 1
fi

read -p "Database name: " dbname
read -p "Database user: " dbuser
read -s -p "Database password: " dbpass
echo

if [[ "$action" == "b" ]]; then
    # ---------- BACKUP ----------
    out_file="${dbname}_backup_$(date +%Y%m%d%H%M%S).sql.gz"
    if [[ "$dbtype" == "mysql" ]]; then
        mysqldump -u "$dbuser" -p"$dbpass" "$dbname" | gzip > "$out_file"
    else
        PGPASSWORD="$dbpass" pg_dump -U "$dbuser" "$dbname" | gzip > "$out_file"
    fi
    if [[ $? -eq 0 ]]; then
        echo "Backup successful: $out_file"
    else
        echo "Backup failed."
    fi
else
    # ---------- RESTORE ----------
    read -p "Path to backup (.sql.gz) file: " infile
    if [[ ! -f "$infile" ]]; then
        echo "Backup file does not exist. Exiting."
        exit 1
    fi
    if [[ "$dbtype" == "mysql" ]]; then
        gunzip < "$infile" | mysql -u "$dbuser" -p"$dbpass" "$dbname"
    else
        gunzip < "$infile" | PGPASSWORD="$dbpass" psql -U "$dbuser" "$dbname"
    fi
    if [[ $? -eq 0 ]]; then
        echo "Restore successful."
    else
        echo "Restore failed. Check credentials and database."
    fi
fi
