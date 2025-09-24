# Google Cloud Run Deployment Scripts for Mayfield Guitars

This directory contains a set of scripts to automate the deployment of the Mayfield Guitars website to Google Cloud Run.

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated.
- An active Google Cloud account.

## Instructions

Follow these steps in order to deploy the application. The setup scripts only need to be run once.

### One-Time Setup

#### 1. Set Up Your Google Cloud Project

Run the following script to either create a new Google Cloud project or use an existing one.

```bash
./gcp/gcloud_setup.sh
```

The script will ask you if you want to create a new project. If you choose to use an existing project, you will be prompted for the project ID. After the project is set, the script will provide a URL to enable or verify billing. You must complete this step before the script can enable the required APIs.

#### 2. Set Up the Artifact Registry

Run this script to create a new Artifact Registry repository for your Docker images.

```bash
./gcp/artifact_registry_setup.sh
```

You will be prompted to enter a region and a name for your repository.

#### 3. Set Up the Service Account

Run this script to create a service account with the required permissions and generate a JSON key for authentication.

```bash
./gcp/service_account_setup.sh
```

This will create a `gcp-credentials.json` file in the `gcp` directory. **Do not commit this file to version control.**

### Deploying the Application

Once the one-time setup is complete, you can deploy the application by running the following script:

```bash
./gcp/cloud_run_deploy.sh
```

You will be prompted to enter the region, repository name, and a service name.

### Stopping the Service

When you are finished, you can stop and delete the Cloud Run service to avoid incurring further costs.

```bash
./gcp/cloud_run_stop.sh
```

You will be prompted to enter the service name and region.

## Security Note

The `gcp-credentials.json` file contains sensitive information. It is recommended to add this file to your `.gitignore` to prevent it from being committed to your repository.