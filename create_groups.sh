#!/bin/env bash

# check if a filename is provided and readable
if [[ -z "$1" || ! -r "$1" ]]; then
    echo "Fehler: Bitte eine gültige und lesbare Datei als Argument angeben."
    echo "Syntax: $0 <dateiname>"
    exit 1
fi

# read filename as argument
input_file="$1"

# read lines of file and create an array from each line
mapfile -t groups < "$input_file"

for group in "${groups[@]}"; do
    if output=$(groupadd "$group" 2>&1); then
        echo "Gruppe '$group' erfolgreich erstellt."
    else
        echo "Fehler beim Erstellen der Gruppe '$group': $output"
    fi
done
