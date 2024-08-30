#!/usr/bin/env bash

# Check if a file is provided and readable
if [[ -z "$1" || ! -r "$1" ]]; then
    echo "Fehler: Bitte eine gültige und lesbare Datei als Argument angeben."
    echo "Syntax: $0 <dateiname>"
    exit 1
fi

# Read filename as argument
input_file="$1"

# Read lines of the file and store them in an array, -t to remove \n at EOL
# Format of line: username[:group_to_add,second_group]  
mapfile -t input < "$input_file"

for line in "${input[@]}"; do
    # Extract username and group names from the input
    user=$(echo $line | cut -d ':' -f 1)
    groups=$(echo $line | cut -d ':' -f 2)

    # Generate a random password
    password=$(openssl rand -base64 12)

    # Add user, set default shell to bash, create home directory
    if output=$(useradd -m -s /bin/bash "$user" 2>&1); then
        echo "Benutzer '$user' erfolgreich angelegt."
    else
        echo "Fehler beim Anlegen des Benutzers '$user': $output"
        # next iteration in for loop, the following code would fail anyways 
        continue
    fi

    # Set password 
    echo "$user:$password" | chpasswd


    # Force password change on the next login
    if output=$(passwd -e "$user" 2>&1); then
        # store stder (2) and stdout (1) in output for later error handeling
        echo "Benutzer '$user' muss beim nächsten Login sein Passwort ändern."
    else
        echo "Fehler beim Erzwingen der Passwortänderung für Benutzer '$user': $output"
    fi

    # Save password to file
    echo "$user:$password" >> passwords.txt

    # If $groups is not empty
    if [ -n "$groups" ]; then
        # Create an array from the comma-separated group string (group1,group2,group3)
        # InternalFieldSeperator, -r don't escape with \, -a append to array, <<< Here string
        IFS=',' read -r -a groups_array <<< "$groups"

        for group in "${groups_array[@]}"; do
            # Add user to group
            if output=$(usermod -aG "$group" "$user" 2>&1); then
                echo "Benutzer '$user' erfolgreich zur Gruppe '$group' hinzugefügt."
            else
                echo "Fehler beim Hinzufügen von Benutzer '$user' zur Gruppe '$group': $output"
            fi
        done
    fi

    echo "Benutzer $user vollständig angelegt."
done
