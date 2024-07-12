#!/bin/bash

# Function to ask the user for input with a default value
ask() {
    local prompt="$1"
    local default="$2"
    local result

    read -p "$prompt [$default]: " result
    echo "${result:-$default}"
}

# Ask the user for session details
SESSION_NAME=$(ask "Enter the tmux session name" "MyTmuxSession")

PROJECTS_PATH=$(ask "Enter the base path for projects" "${HOME}/Projects")

REPO_COUNT=$(ask "How many repositories? (1 or 2)" "1")
REPO1_PATH=$(ask "Enter the path for repository 1" "${PROJECTS_PATH}/repo1")

if [[ "$REPO_COUNT" == "2" ]]; then
    REPO2_PATH=$(ask "Enter the path for repository 2" "${PROJECTS_PATH}/repo2")
fi

# Confirm the provided information
echo "Summary of the provided information:"
echo "Session name: $SESSION_NAME"
echo "Base path for projects: $PROJECTS_PATH"
echo "Path for repository 1: $REPO1_PATH"
[[ "$REPO_COUNT" == "2" ]] && echo "Path for repository 2: $REPO2_PATH"
echo

# Function to add a window and its commands in tmux
add_window() {
    local window_name="$1"
    local commands="$2"

    tmux new-window -n "$window_name"
    IFS=$'\n'
    for cmd in $commands; do
        tmux send-keys "$cmd" C-m
    done
    IFS=$' '
}

# If the session already exists, attach to it
if tmux attach-session -d -t ${SESSION_NAME}; then
    exit
fi

# Create the tmux session
tmux new-session -d -s ${SESSION_NAME}

# Tools window
tools_commands="webstorm &\npycharm &\nfirefox &\ngedit ${HOME}/notes &"
add_window "tools" "$tools_commands"

# Repository 1 window
repo1_commands="cd ${REPO1_PATH}\ngit status"
add_window "repo1" "$repo1_commands"

# Run repository 1 window
run_repo1_commands="cd ${REPO1_PATH}\ndocker-compose up -d\ndocker-compose -f docker-compose.dev.yml logs -f"
add_window "run-repo1" "$run_repo1_commands"

if [[ "$REPO_COUNT" == "2" ]]; then
    # Repository 2 window
    repo2_commands="cd ${REPO2_PATH}\ngit status"
    add_window "repo2" "$repo2_commands"

    # Run repository 2 window
    run_repo2_commands="cd ${REPO2_PATH}\ndocker-compose up -d\ndocker-compose -f docker-compose.dev.yml logs -f"
    add_window "run-repo2" "$run_repo2_commands"
fi

# Work window
work_commands="zen\ncd ${BASHORTCUT}"
add_window "work" "$work_commands"

# Attach to the session once all windows are created
tmux attach-session -t ${SESSION_NAME}
