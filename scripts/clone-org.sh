#!/bin/bash

# Define the GitHub organization and the new directory name
ORG="polyglot-microservices-org"
DEST_DIR="polyglot-org"

# List of repositories to clone
REPOS=(
  "infra-terraform"
  "infra-k8s"
  "frontend"
  "ai-cheatsheet-maker"
  "user-service"
  "todo-service"
  "notes-service"
)

# Create the destination directory if it doesn't exist
echo "Creating directory: $DEST_DIR"
mkdir -p "$DEST_DIR"

# Change to the new directory
cd "$DEST_DIR"

# Loop through each repository and clone it
for repo in "${REPOS[@]}"; do
  echo "Cloning $repo..."
  git clone "https://github.com/$ORG/$repo.git"
  if [ $? -eq 0 ]; then
    echo "Successfully cloned $repo."
  else
    echo "Failed to clone $repo."
  fi
  echo "---"
done

echo "All specified repositories have been processed and are located in the '$DEST_DIR' folder."
