#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the current project ID from gcloud config
PROJECT_ID=$(gcloud config get-value project)

if [ -z "$PROJECT_ID" ]; then
    echo "No active Google Cloud project found. Please run gcloud_setup.sh first or set a project using 'gcloud config set project YOUR_PROJECT_ID'."
    exit 1
fi

# Prompt for a service account name
read -p "Enter a name for your service account (e.g., cloud-run-deployer): " SERVICE_ACCOUNT_NAME

# Create the service account
echo "Creating service account: $SERVICE_ACCOUNT_NAME..."
gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME" \
  --display-name="$SERVICE_ACCOUNT_NAME" \
  --project="$PROJECT_ID"

# Construct the service account email
SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# Assign necessary roles to the service account
echo "Assigning roles to service account..."

# Role for Cloud Build to build and push images
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/cloudbuild.builds.builder"

# Role for Cloud Run deployment
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/run.admin"

# Role to act as the Cloud Run service's runtime identity
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/iam.serviceAccountUser"

# Role to push to Artifact Registry
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/artifactregistry.writer"

# Generate a JSON key for the service account
echo "Generating JSON key for the service account..."
gcloud iam service-accounts keys create "gcp/gcp-credentials.json" \
  --iam-account="$SERVICE_ACCOUNT_EMAIL" \
  --project="$PROJECT_ID"

echo "Service account setup is complete. The key has been saved to gcp/gcp-credentials.json."
echo "IMPORTANT: Keep this file secure and do not commit it to version control."