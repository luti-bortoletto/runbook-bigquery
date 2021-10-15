# Welcome to the Dataflow Streaming Tutorial

## Intro

In this tutorial we'll create the following scenario:

![runbook-streaming](https://user-images.githubusercontent.com/12385160/119853137-4daef800-bee6-11eb-9256-8b19b203d06c.png)

1. Generate JSON Files through a schema with fake info and populate a PubSub Topic
2. Stream Data from PubSub | Transform the JSON file into rows | Populate a Big Query Table

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
cloudshell launch-tutorial -d dataflow/streaming-pubsub-bq.md
```