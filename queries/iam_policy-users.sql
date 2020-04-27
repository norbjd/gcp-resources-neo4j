# retrieve all users with IAM bindings on handled assets
SELECT
  DISTINCT SPLIT(member, ':')[OFFSET(1)] AS email
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.iam_policy`,
  UNNEST(iam_policy.bindings) AS bindings,
  UNNEST(bindings.members) AS member
WHERE
  SPLIT(member, ':')[OFFSET(0)] = "user"
  AND asset_type IN (
    "cloudresourcemanager.googleapis.com/Organization",
    "cloudresourcemanager.googleapis.com/Folder",
    "cloudresourcemanager.googleapis.com/Project",
    "storage.googleapis.com/Bucket",
    "bigquery.googleapis.com/Dataset")
