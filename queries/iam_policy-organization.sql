SELECT
  SPLIT(member, ':')[OFFSET(0)] AS accountType,
  SPLIT(member, ':')[OFFSET(1)] AS email,
  bindings.role AS role,
  SPLIT(name, '/')[OFFSET(4)] AS organizationId
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.iam_policy`,
  UNNEST(iam_policy.bindings) AS bindings,
  UNNEST(bindings.members) AS member
WHERE
  asset_type = "cloudresourcemanager.googleapis.com/Organization"
