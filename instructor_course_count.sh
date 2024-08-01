#!/bin/bash

read -p "Enter instructor name: " INSTRUCTOR

INSTRUCTOR_EXISTS=$(awk -F, -v instructor="$INSTRUCTOR" '$4 == instructor {print $4}' timetable.csv | head -n 1)

if [ -z "$INSTRUCTOR_EXISTS" ]; then
    echo "Invalid instructor: $INSTRUCTOR"
    exit 1
fi

COURSE_COUNT=$(awk -F, -v instructor="$INSTRUCTOR" '$4 == instructor {print $3}' timetable.csv | sort | uniq | wc -l)

echo "$INSTRUCTOR teaches $COURSE_COUNT courses"

