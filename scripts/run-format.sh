#!/bin/bash

# Function to check if a command is installed globally and provide installation instructions if it's not found
check_command() {
    local command_name=$1
    local install_command=$2

    if ! command -v "$command_name" &> /dev/null; then
        echo "$command_name is not installed."
        echo "To install $command_name, run: $install_command"
        return 1
    fi

    return 0
}

# Check if isort and black are installed globally
check_command "isort" "pip install isort" || return 1
check_command "black" "pip install black" || return 1

# Sort code using isort with black profile
isort --profile black -l 100 ./pyv

# Format code using black
black -l 100 ./pyv

# Check if "markdownlint-cli2 is installed globally
check_command "markdownlint-cli2" "npm install markdownlint-cli2 --global" || return 1

# If markdownlint-cli2 is installed, fix linting issues in Markdown files
markdownlint-cli2 *.md --fix
