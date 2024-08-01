#!/bin/bash

read -p "Enter course name: " COURSE

COURSE_EXISTS=$(awk -F, -v course="$COURSE" '$3 == course {print $3}' timetable.csv | head -n 1)

if [ -z "$COURSE_EXISTS" ]; then
    echo "Invalid course: $COURSE"
    exit 1
fi

echo "Timetable for course $COURSE:"
awk -F, -v course="$COURSE" '$3 == course' timetable.csv

