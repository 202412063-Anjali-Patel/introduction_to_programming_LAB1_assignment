#!/bin/bash

read -p "Enter room name: " ROOM

ROOM_EXISTS=$(awk -F, -v room="$ROOM" '$5 == room {print $5}' timetable.csv | head -n 1)

if [ -z "$ROOM_EXISTS" ]; then
    echo "Invalid room: $ROOM"
    exit 1
fi

echo "Courses held in room $ROOM:"
awk -F, -v room="$ROOM" '$5 == room {print $3}' timetable.csv | sort | uniq

