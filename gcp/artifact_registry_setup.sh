#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the current project ID from gcloud config
PROJECT_ID=$(gcloud config get-value project)

if [ -z "$PROJECT_ID" ]; then
    echo "No active Google Cloud project found. Please run gcloud_setup.sh first or set a project using 'gcloud config set project YOUR_PROJECT_ID'."
    exit 1
fi

# Prompt for a region
read -p "Enter the region for your Artifact Registry repository (e.g., us-central1): " REGION

# Prompt for a repository name
read -p "Enter a name for your Artifact Registry repository (e.g., mayfieldguitars-repo): " REPO_NAME

# Create the Artifact Registry repository
echo "Creating Artifact Registry repository..."
gcloud artifacts repositories create "$REPO_NAME" \
  --repository-format=docker \
  --location="$REGION" \
  --description="Docker repository for Mayfield Guitars"

echo "Artifact Registry repository '$REPO_NAME' created successfully in region '$REGION'."