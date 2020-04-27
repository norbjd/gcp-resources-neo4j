SELECT
  role,
  REPLACE(REGEXP_REPLACE(includedPermissions, '[\\["\\]]', ""), ',', ';') AS permissions
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(resource.data,
      '$.name') AS role,
    JSON_EXTRACT(resource.data,
      '$.includedPermissions') AS includedPermissions
  FROM
    `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.resource`
  WHERE
    asset_type = "iam.googleapis.com/Role" )
