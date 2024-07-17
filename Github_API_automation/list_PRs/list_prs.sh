#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to get PRs
function list_prs {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/pulls"

    # Fetch the list of PRs on the repository
    response="$(github_api_get "$endpoint")" 

    # Check if response is not empty
if [ -z "$response" ]; then
    echo "No response from GitHub API"
    exit 1
fi

# Parse and list pull requests
echo "Listing Pull Requests for $REPO_OWNER/$REPO_NAME:"
echo "$response" | jq -r '.[] | "PR #\(.number): \(.title) by \(.user.login)"'
}

# Main script

list_prs
