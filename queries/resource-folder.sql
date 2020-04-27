SELECT
  SPLIT(JSON_EXTRACT_SCALAR(resource.data,
      '$.name'), '/')[OFFSET(1)] AS id,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.name') AS name,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.displayName') AS displayName,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.parent') AS parent
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
WHERE
  asset_type = "cloudresourcemanager.googleapis.com/Folder"
