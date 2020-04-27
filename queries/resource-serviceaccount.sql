SELECT
  JSON_EXTRACT_SCALAR(resource.data,
    '$.uniqueId') AS id,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.name') AS name,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.email') AS email,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.displayName') AS displayName,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.projectId') AS projectId,
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
WHERE
  asset_type = "iam.googleapis.com/ServiceAccount"
