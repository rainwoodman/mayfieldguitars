# Google Cloud Run Deployment Scripts for Mayfield Guitars

This directory contains a set of scripts to automate the deployment of the Mayfield Guitars website to Google Cloud Run.

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated.
- An active Google Cloud account with billing enabled.

## Instructions

Follow these steps in order to deploy the application:

### 1. Set Up Your Google Cloud Project

Run the following script to create a new Google Cloud project and enable the necessary APIs. You will be prompted to enter a project ID.

```bash
./gcp/gcloud_setup.sh
```

After the script completes, you will be given a URL to enable billing for your new project. This is a required step.

### 2. Set Up the Service Account

Run this script to create a service account with the required permissions and generate a JSON key for authentication.

```bash
./gcp/service_account_setup.sh
```

This will create a `gcp-credentials.json` file in the `gcp` directory. **Do not commit this file to version control.**

### 3. Deploy to Cloud Run

Run this script to build the Docker image, push it to the Artifact Registry, and deploy it to Cloud Run.

```bash
./gcp/cloud_run_deploy.sh
```

You will be prompted to enter a region, a repository name, and a service name.

### 4. Stop and Delete the Service

When you are finished, you can stop and delete the Cloud Run service to avoid incurring further costs.

```bash
./gcp/cloud_run_stop.sh
```

You will be prompted to enter the service name and region.

## Security Note

The `gcp-credentials.json` file contains sensitive information. It is recommended to add this file to your `.gitignore` to prevent it from being committed to your repository.