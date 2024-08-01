#!/bin/bash

TODAY=$(date +%A)

grep "$TODAY" timetable.csv
