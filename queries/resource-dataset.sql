SELECT
  JSON_EXTRACT_SCALAR(resource.data,
    '$.id') AS id,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.datasetReference.projectId') AS projectId,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.datasetReference.datasetId') AS datasetId,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.location') AS location
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
WHERE
  asset_type = "bigquery.googleapis.com/Dataset"
