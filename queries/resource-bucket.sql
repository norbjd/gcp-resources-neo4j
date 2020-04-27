SELECT
  JSON_EXTRACT_SCALAR(resource.data,
    '$.name') AS id,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.projectNumber') AS projectNumber,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.location') AS location,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.storageClass') AS storageClass,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.timeCreated') AS timeCreated,
  JSON_EXTRACT_SCALAR(resource.data,
    '$.iamConfiguration.bucketPolicyOnly.enabled') AS bucketPolicyOnlyLocked
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
WHERE
  asset_type = "storage.googleapis.com/Bucket"
