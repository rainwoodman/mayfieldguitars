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

# Inform the user to enable billing
echo "Your project has been created. Before proceeding, you must enable billing."
echo "Visit the following URL in your browser to associate a billing account with your project:"
echo "https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"
echo ""
read -p "After you have enabled billing, press [Enter] to continue..."

# Enable necessary APIs
echo "Enabling required APIs..."
gcloud services enable \
  cloudbuild.googleapis.com \
  run.googleapis.com \
  artifactregistry.googleapis.com \
  cloudresourcemanager.googleapis.com \
  iam.googleapis.com

echo "Project setup and API enablement are complete."