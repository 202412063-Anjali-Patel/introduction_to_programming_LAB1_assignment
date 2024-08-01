#!/bin/bash

CLASS_START="09:00"
CLASS_END="17:00"

CURRENT_TIME=$(date +"%H:%M")

read -p "Enter instructor name: " INSTRUCTOR_NAME

INSTRUCTOR_EXISTS=$(awk -F, -v instructor="$INSTRUCTOR_NAME" '$4 == instructor {print $4}' timetable.csv | head -n 1)

if [ -z "$INSTRUCTOR_EXISTS" ]; then
    echo "Invalid instructor: $INSTRUCTOR_NAME"
    exit 1
fi

if [[ "$CURRENT_TIME" > "$CLASS_START" && "$CURRENT_TIME" < "$CLASS_END" ]]; then
    echo "$INSTRUCTOR_NAME is currently in class"
else
    echo "$INSTRUCTOR_NAME is in the office"
fi

