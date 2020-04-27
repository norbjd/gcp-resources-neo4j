#!/usr/bin/env sh

set -eux

# Usage : ./gcp_resources_neo4j.sh <organization_id> <YYYY-mm-ddTHH:mm:ssZ> <project> <dataset>
ORGANIZATION_ID="$1"
SNAPSHOT_TIME="$2"
BIGQUERY_EXPORT_PROJECT="$3"
BIGQUERY_EXPORT_DATASET="$4"

./assets_to_bq.sh "$ORGANIZATION_ID" "$SNAPSHOT_TIME" "$BIGQUERY_EXPORT_PROJECT" "$BIGQUERY_EXPORT_DATASET"
./bq_to_csv.sh "$BIGQUERY_EXPORT_PROJECT" "$BIGQUERY_EXPORT_DATASET"

echo "Removing tables..."
bq rm --force --table "$BIGQUERY_EXPORT_PROJECT:$BIGQUERY_EXPORT_DATASET.resource"
bq rm --force --table "$BIGQUERY_EXPORT_PROJECT:$BIGQUERY_EXPORT_DATASET.iam_policy"
echo "Tables removed!"

./csv_to_neo4j.sh "$ORGANIZATION_ID" "$SNAPSHOT_TIME"