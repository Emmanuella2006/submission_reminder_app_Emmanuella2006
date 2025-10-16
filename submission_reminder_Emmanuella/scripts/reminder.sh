#!/bin/bash
# This script runs the reminder app

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING"
echo "---------------------------------------"

check_submissions $submissions_file
