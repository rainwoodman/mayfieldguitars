#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Ask the user if they want to create a new project
read -p "Do you want to create a new Google Cloud project? (y/n) " CREATE_NEW_PROJECT

if [[ "$CREATE_NEW_PROJECT" =~ ^[Yy]$ ]]; then
  # Prompt for a new project ID
  read -p "Enter your desired Google Cloud project ID: " PROJECT_ID

  # Create a new Google Cloud project
  echo "Creating Google Cloud project: $PROJECT_ID..."
  gcloud projects create "$PROJECT_ID"
else
  # Prompt for the existing project ID
  read -p "Enter your existing Google Cloud project ID: " PROJECT_ID
fi

# Set the new/existing project as the active project
echo "Setting active project to $PROJECT_ID..."
gcloud config set project "$PROJECT_ID"

# Inform the user to enable billing
echo "Your project is set. Before proceeding, please ensure billing is enabled."
echo "Visit the following URL in your browser to verify or associate a billing account with your project:"
echo "https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"
echo ""
read -p "After you have verified billing, press [Enter] to continue..."

# Enable necessary APIs
echo "Enabling required APIs..."
gcloud services enable \
  cloudbuild.googleapis.com \
  run.googleapis.com \
  artifactregistry.googleapis.com \
  cloudresourcemanager.googleapis.com \
  iam.googleapis.com

echo "Project setup and API enablement are complete."