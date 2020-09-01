#!/usr/bin/env sh

set -eux

ORGANIZATION_ID="$1"
SNAPSHOT_TIME="$2"
BIGQUERY_EXPORT_PROJECT="$3"
BIGQUERY_EXPORT_DATASET="$4"

ASSET_TYPES="cloudresourcemanager.googleapis.com/Organization,cloudresourcemanager.googleapis.com/Folder,cloudresourcemanager.googleapis.com/Project,storage.googleapis.com/Bucket,bigquery.googleapis.com/Dataset,iam.googleapis.com/ServiceAccount,iam.googleapis.com/Role"

ASSET_EXPORT_OPERATION_RESOURCE=$(gcloud asset export \
	--organization=$ORGANIZATION_ID \
	--bigquery-table="projects/$BIGQUERY_EXPORT_PROJECT/datasets/$BIGQUERY_EXPORT_DATASET/tables/resource" \
	--asset-types=$ASSET_TYPES \
	--snapshot-time=$SNAPSHOT_TIME \
	--output-bigquery-force \
	--content-type='resource' 2>&1 >/dev/null | \
	grep -o "organizations/$ORGANIZATION_ID/operations/ExportAssets/[^/]*/[a-z0-9]*")

echo "Operation $ASSET_EXPORT_OPERATION_RESOURCE launched!"

ASSET_EXPORT_OPERATION_IAM_POLICY=$(gcloud asset export \
	--organization=$ORGANIZATION_ID \
	--bigquery-table="projects/$BIGQUERY_EXPORT_PROJECT/datasets/$BIGQUERY_EXPORT_DATASET/tables/iam_policy" \
	--asset-types=$ASSET_TYPES \
	--snapshot-time=$SNAPSHOT_TIME \
	--output-bigquery-force \
	--content-type='iam-policy' 2>&1 >/dev/null | \
	grep -o "organizations/$ORGANIZATION_ID/operations/ExportAssets/[^/]*/[a-z0-9]*")

echo "Operation $ASSET_EXPORT_OPERATION_IAM_POLICY launched!"

while [[ $(gcloud asset operations describe "$ASSET_EXPORT_OPERATION_RESOURCE" --format="value(done)") != "True" ]]
do
	echo "Waiting until $ASSET_EXPORT_OPERATION_RESOURCE is done..."
	sleep 1
done
echo "Operation $ASSET_EXPORT_OPERATION_RESOURCE done!"

while [[ $(gcloud asset operations describe "$ASSET_EXPORT_OPERATION_IAM_POLICY" --format="value(done)") != "True" ]]
do
	echo "Waiting until $ASSET_EXPORT_OPERATION_IAM_POLICY is done..."
	sleep 1
done
echo "Operation $ASSET_EXPORT_OPERATION_IAM_POLICY done!"
