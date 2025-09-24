#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Prompt for a project ID
read -p "Enter your desired Google Cloud project ID: " PROJECT_ID

# Create a new Google Cloud project
echo "Creating Google Cloud project: $PROJECT_ID..."
gcloud projects create "$PROJECT_ID"

# Set the new project as the active project
echo "Setting active project to $PROJECT_ID..."
gcloud config set project "$PROJECT_ID"

# Enable necessary APIs
echo "Enabling required APIs..."
gcloud services enable \
  cloudbuild.googleapis.com \
  run.googleapis.com \
  artifactregistry.googleapis.com \
  cloudresourcemanager.googleapis.com \
  iam.googleapis.com

# Inform the user to enable billing
echo "Project setup is almost complete. Please enable billing for your project."
echo "Visit the following URL to enable billing:"
echo "https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"