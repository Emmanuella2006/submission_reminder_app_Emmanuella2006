#!/bin/bash
# Starts the submission reminder app

echo "Starting the Submission Reminder App..."
bash ./scripts/reminder.sh

find $submission_reminder_Emmanuella -type f -name '*.sh' -print0 | xargs -0 chmod a+x
