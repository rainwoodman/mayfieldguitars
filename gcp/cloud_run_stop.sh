#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the current project ID from gcloud config
PROJECT_ID=$(gcloud config get-value project)

if [ -z "$PROJECT_ID" ]; then
    echo "No active Google Cloud project found. Please run gcloud_setup.sh first or set a project using 'gcloud config set project YOUR_PROJECT_ID'."
    exit 1
fi

# Prompt for the service name
read -p "Enter the name of the Cloud Run service to stop and delete: " SERVICE_NAME

# Prompt for the region
read -p "Enter the region of the Cloud Run service: " REGION

# Delete the Cloud Run service
echo "Deleting Cloud Run service: $SERVICE_NAME..."
gcloud run services delete "$SERVICE_NAME" \
  --platform=managed \
  --region="$REGION" \
  --quiet

echo "Cloud Run service has been deleted."