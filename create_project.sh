#!/usr/bin/env bash

# prepare /etc/skel
for folder in Documents Downloads Pictures Music Videos Templates Desktop Public; do
    if output=$(mkdir -p /etc/skel/$folder 2>&1); then
        echo "Ordner '/etc/skel/$folder' erfolgreich erstellt."
    else
        echo "Fehler beim Erstellen des Ordners '/etc/skel/$folder': $output"
    fi
done

# create project folders in /home
mkdir -p /home/firma/{boss/bill,hr/{jim,john},it/{alice,bob},sale/{tim,tom}}

# create groups
./create_groups.sh groups.txt

# create users and add them to groups
./create_users.sh users.txt

# set folder permissions
# go through all directories recursively
# find all directories in /home/firma, read them literally as $dir and loop
# while read gets piped input from find
find /home/firma -type d | while read -r dir; do
    # Extract the basename of the current directory
    dir_name=$(basename "$dir")

    # Change ownership to bill and the group corresponding to the directory name
    chown bill:"$dir_name" "$dir"
    echo "chown bill:$dir_name $dir"

    # Set permissions to 770
    chmod 770 "$dir"
    echo "chmod 770 $dir"
done


