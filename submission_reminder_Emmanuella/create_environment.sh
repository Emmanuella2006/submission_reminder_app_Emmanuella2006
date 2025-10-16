#!/bin/bash
# create_environment.sh
# This script creates the environment for my
# submission reminder application.


# Ask for the user’s name
echo "Please enter your name:"
read name

# Create main directory using your name
main_folder="submission_reminder_Emmanuella"
mkdir -p "$main_folder"

# Move into the main directory
cd "$main_folder" || exit

# Create the subfolders
mkdir -p config modules scripts assets

# Create the config.env file inside config folder
cat <<EOL > config/config.env
# Configuration file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Create the functions.sh file inside modules folder
cat <<'EOL' > modules/functions.sh
#!/bin/bash
# This function checks which students have not submitted

function check_submissions {
    local submissions_file=$1
    echo "Checking submissions from: $submissions_file"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOL

# Create the reminder.sh file inside scripts folder
cat <<'EOL' > scripts/reminder.sh
#!/bin/bash
# This script runs the reminder app

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING"
echo "---------------------------------------"

check_submissions $submissions_file
EOL

# Create the submissions.txt file inside assets folder
cat <<EOL > assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emmanuella, Shell Navigation, not submitted
Gloria, Shell Basics, submitted
Michael, Git, not submitted
Precious, Shell Navigation, submitted
Oluwanifemi, Git, not submitted
EOL

# Create startup.sh file (this one starts the app)
cat <<'EOL' > startup.sh
#!/bin/bash
# Starts the submission reminder app

echo "Starting the Submission Reminder App..."
bash ./scripts/reminder.sh
EOL

# Make all .sh files executable
find . -type f -name "*.sh" -exec chmod +x {} \;

# Finish message
echo "Setup, successfully complete!"
echo "Your app folder is ready: $main_folder"
echo "To start the app, type: ./startup.sh"
