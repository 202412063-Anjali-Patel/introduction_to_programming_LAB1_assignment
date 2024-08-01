#!/bin/bash

read -p "Enter the room name (or press Enter to count for all rooms): " ROOM_NAME

CSV_FILE="timetable.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "Error: $CSV_FILE does not exist."
    exit 1
fi

if [ -n "$ROOM_NAME" ]; then
    ROOM_EXISTS=$(awk -F, -v room="$ROOM_NAME" '$5 == room {print $5}' "$CSV_FILE" | head -n 1)

    if [ -z "$ROOM_EXISTS" ]; then
        echo "Invalid room name: $ROOM_NAME"
        exit 1
    fi

    for DAY in Monday Tuesday Wednesday Thursday Friday; do
        COUNT=$(awk -F, -v room="$ROOM_NAME" -v day="$DAY" '$1 == day && $5 == room {count++} END {print count}' "$CSV_FILE")
        echo "$ROOM_NAME, $DAY, $COUNT"
    done
else
    echo "Room, Day, Count"
    ROOMS=$(awk -F, '{print $5}' "$CSV_FILE" | sort | uniq)

    for ROOM in $ROOMS; do
        for DAY in Monday Tuesday Wednesday Thursday Friday; do
            COUNT=$(awk -F, -v room="$ROOM" -v day="$DAY" '$1 == day && $5 == room {count++} END {print count}' "$CSV_FILE")
            echo "$ROOM, $DAY, $COUNT"
        done
    done
fi

