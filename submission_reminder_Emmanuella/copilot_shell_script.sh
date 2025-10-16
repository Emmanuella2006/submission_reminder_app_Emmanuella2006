#!/bin/bash

# Prompt for new assignment name
echo "Enter the new assignment name:"
read new_assignment

# Update the ASSIGNMENT value in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=$new_assignment/" config/config.env

echo "Assignment updated to '$new_assignment' in config.env."

# Run the reminder app again
bash startup.sh

