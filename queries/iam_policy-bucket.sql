SELECT
  SPLIT(name, '/')[
OFFSET
  (3)] AS id,
  bindings.role,
  CASE
    WHEN STARTS_WITH(member, 'project') OR STARTS_WITH(member, 'allUsers') OR STARTS_WITH(member, 'allAuthenticatedUsers') THEN 'specialGroup'
  ELSE
  SPLIT(member, ':')[
OFFSET
  (0)]
END
  AS accountType,
  CASE
    WHEN STARTS_WITH(member, 'project') OR STARTS_WITH(member, 'allUsers') OR STARTS_WITH(member, 'allAuthenticatedUsers') THEN member
  ELSE
  SPLIT(member, ':')[
OFFSET
  (1)]
END
  AS account
FROM
  `$BIGQUERY_EXPORT_PROJECT.$BIGQUERY_EXPORT_DATASET.iam_policy`,
  UNNEST(iam_policy.bindings) AS bindings,
  UNNEST(bindings.members) AS member
WHERE
  asset_type = "storage.googleapis.com/Bucket"
