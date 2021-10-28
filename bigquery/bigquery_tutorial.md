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

## Google Cloud Storage (GCS)

### Create bucket
```bash
  gsutil mb -p {{project-id}} -c STANDARD -l southamerica-east1 -b on gs://tutorials-$USER
```

### Load file to bucket
```bash
gsutil cp arquivos/sample.csv gs://tutorials-$USER
```

## BigQuery Dataset/Table

### Create Dataset
```bash
bq --location=southamerica-east1 mk \
--dataset \
--description "Tutorial Dataset" \
{{project-id}}:$USER
```

### Create table
```bash
bq mk \
-t \
--description "Bigquery table raw" \
{{project-id}}:$USER.tb_bigquery_raw \
cpf:STRING,matricula:STRING,sobrenome:STRING,nome:STRING,email:STRING,data_de_ingresso:STRING
```

### Load csv from GCS to BQ raw table 
```bash
bq load \
--source_format=CSV \
--project_id={{project-id}} \
--skip_leading_rows=1 \
--quote='' \
{{project-id}}:$USER.tb_bigquery_raw \
gs://tutorials-$USER/sample.csv \
cpf:STRING,matricula:STRING,sobrenome:STRING,nome:STRING,email:STRING,data_de_ingresso:STRING
```

### Create and load trusted table from raw
```bash
bq query --project_id=bv-ti-arqdados-sandbox \
--quiet \
--destination_table {{project-id}}:$USER.tb_bigquery_trusted \
--use_legacy_sql=false \
'SELECT
cpf,
matricula,
nome_completo,
data_de_ingresso 
FROM (
SELECT
cpf,
CAST(matricula 
as INT64) 
as matricula,
CONCAT(nome, 
" ", 
sobrenome) 
as nome_completo,
email,
PARSE_DATETIME(
"%A %b %e %H:%M:%S %Y",
data_de_ingresso) 
as data_de_ingresso,
ROW_NUMBER() 
OVER(
PARTITION BY 
matricula 
ORDER BY 
CONCAT(
nome, 
" ", 
sobrenome) 
ASC) 
rank_matricula
FROM 
{{project-id}}.$USER.tb_bigquery_raw
) AS t1 
WHERE rank_matricula = 1'
```
### Create and load trusted table from raw
```bash
bq query --project_id=bv-ti-arqdados-sandbox \
--quiet \
--destination_table {{project-id}}:$USER.tb_bigquery_trusted \
--use_legacy_sql=false \
--parameter=ds_name::$USER \
'SELECT
cpf,
matricula,
nome_completo,
data_de_ingresso 
FROM (
SELECT
cpf,
CAST(matricula 
as INT64) 
as matricula,
CONCAT(nome, 
" ", 
sobrenome) 
as nome_completo,
email,
PARSE_DATETIME(
"%A %b %e %H:%M:%S %Y",
data_de_ingresso) 
as data_de_ingresso,
ROW_NUMBER() 
OVER(
PARTITION BY 
matricula 
ORDER BY 
CONCAT(
nome, 
" ", 
sobrenome) 
ASC) 
rank_matricula
FROM 
{{project-id}}.@ds_name.tb_bigquery_raw
) AS t1 
WHERE rank_matricula = 1'
```
