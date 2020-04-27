SELECT
  JSON_EXTRACT_SCALAR(resource.data,
    '$.projectId') AS id,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.projectNumber') AS projectNumber,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.name') AS name,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.createTime') AS createTime,
  CONCAT(JSON_EXTRACT_SCALAR(resource.data,
      '$.parent.type'), 's/', JSON_EXTRACT_SCALAR(resource.data,
      '$.parent.id')) AS parentId
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
WHERE
  asset_type = "cloudresourcemanager.googleapis.com/Project"
