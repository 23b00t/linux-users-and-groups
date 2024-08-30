#!/usr/bin/env bash

# check if a filename is provided and readable
if [[ -z "$1" || ! -r "$1" ]]; then
    echo "Fehler: Bitte eine gültige und lesbare Datei als Argument angeben."
    echo "Syntax: $0 <dateiname>"
    exit 1
fi

# read filename as argument
input_file="$1"

# Read lines of the file and store them in an array, -t to remove \n at EOL
mapfile -t groups < "$input_file"

for group in "${groups[@]}"; do
    # store stder (2) and stdout (1) in output for later error handeling
    if output=$(groupadd "$group" 2>&1); then
        echo "Gruppe '$group' erfolgreich erstellt."
    else
        echo "Fehler beim Erstellen der Gruppe '$group': $output"
    fi
done
