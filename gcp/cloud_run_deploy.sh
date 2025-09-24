#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the current project ID from gcloud config
PROJECT_ID=$(gcloud config get-value project)

if [ -z "$PROJECT_ID" ]; then
    echo "No active Google Cloud project found. Please run gcloud_setup.sh first or set a project using 'gcloud config set project YOUR_PROJECT_ID'."
    exit 1
fi

# Authenticate with the service account
echo "Authenticating with the service account..."
gcloud auth activate-service-account --key-file="gcp/gcp-credentials.json"

# Prompt for a region
read -p "Enter the region for your Artifact Registry and Cloud Run service (e.g., us-central1): " REGION

# Prompt for a repository name
read -p "Enter a name for your Artifact Registry repository (e.g., mayfieldguitars-repo): " REPO_NAME

# Create the Artifact Registry repository
echo "Creating Artifact Registry repository..."
gcloud artifacts repositories create "$REPO_NAME" \
  --repository-format=docker \
  --location="$REGION" \
  --description="Docker repository for Mayfield Guitars"

# Prompt for a service name
read -p "Enter a name for your Cloud Run service (e.g., mayfieldguitars-service): " SERVICE_NAME

# Build the Docker image with Cloud Build
echo "Building Docker image with Cloud Build..."
gcloud builds submit --tag "${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${SERVICE_NAME}:latest" .

# Deploy to Cloud Run
echo "Deploying to Cloud Run..."
gcloud run deploy "$SERVICE_NAME" \
  --image="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${SERVICE_NAME}:latest" \
  --platform=managed \
  --region="$REGION" \
  --allow-unauthenticated

echo "Deployment complete. Your service is available at the URL provided above."