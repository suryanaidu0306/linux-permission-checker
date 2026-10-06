#!/bin/bash

echo "=================================="
echo " LINUX FILE PERMISSION CHECKER"
echo "=================================="

TARGET="${1:-.}"

if [ ! -d "$TARGET" ]; then
    echo "Error: Directory not found!"
    exit 1
fi

echo ""
echo "Checking directory: $TARGET"
echo ""

for FILE in "$TARGET"/*; do

    [ -e "$FILE" ] || continue

    PERMISSION=$(stat -c "%A" "$FILE")
    NAME=$(basename "$FILE")

    echo "File: $NAME"
    echo "Permission: $PERMISSION"

    if [ -f "$FILE" ] && [ -r "$FILE" ] && [ -w "$FILE" ]; then
        echo "Status: Readable and writable"
    fi

    if [ -f "$FILE" ] && [ -x "$FILE" ]; then
        echo "Status: Executable file"
    fi

    if [ -f "$FILE" ] && [ -r "$FILE" ] && [ -w "$FILE" ] && [ -x "$FILE" ]; then
        echo "WARNING: File is accessible for read, write and execution!"
    fi

    echo "-----------------------------"

done

echo "Permission audit completed!"
