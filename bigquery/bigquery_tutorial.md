# Welcome to the BigQuery Tutorial

## Intro

In this tutorial we'll create the following scenario:

1. Create table in bq
2. Load table with csv file
3. Check/view table load

## Set the GCP Project

Pick up your project

<walkthrough-project-setup></walkthrough-project-setup>

## Pre-reqs

To be able to run the next steps, you're gonna need a valid GCP project with the following configs:


 - BigQuery API Enabled
 - At least permission to create/write:
    - BQ table/dataset
    - GCS Bucket


### Turn on Google Cloud APIs (beta)

<walkthrough-enable-apis apis=
  "compute.googleapis.com,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery">
</walkthrough-enable-apis>

For further details, please check the GCP documentation according to the component.

## Visiting google Console

[ ! ] *This tutorial does not work well if you're using Cloud Shell in a separate window.*

Please click [here](https://console.cloud.google.com/home/dashboard?project={{project-id}}&cloudshell=true) for a better experience

After opening the GCP console page, copy/paste the following command in the cloudshell:
```bash
cloudshell launch-tutorial -d bigquery/bigquery_tutorial.md
```
