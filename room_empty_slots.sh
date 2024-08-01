#!/bin/bash
read -p "Enter the room name: " ROOM_NAME

if [ -z "$ROOM_NAME" ]; then
    echo "Error: No room name provided."
    exit 1
fi

ROOM_EXISTS=$(awk -F, -v room="$ROOM_NAME" '$5 == room {print $5}' timetable.csv | head -n 1)

if [ -z "$ROOM_EXISTS" ]; then
    echo "Invalid room name: $ROOM_NAME"
    exit 1
fi

DAYS=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday")

for DAY in "${DAYS[@]}"; do
   
    OCCUPIED_SLOTS=$(awk -F, -v room="$ROOM_NAME" -v day="$DAY" '$1 == day && $5 == room {print $2}' timetable.csv)
    
    if [ -z "$OCCUPIED_SLOTS" ]; then
        echo "$DAY: The room $ROOM_NAME is empty all day."
    else
        echo "$DAY: The room $ROOM_NAME is occupied at the following times:"
        echo "$OCCUPIED_SLOTS"
    fi
    
    echo "---------------------------------"
done

