#!/usr/bin/env sh

set -eux

BIGQUERY_EXPORT_PROJECT="$1"
BIGQUERY_EXPORT_DATASET="$2"

echo "Querying..."
mkdir -p results
for sql_file in `ls queries/`
do
	echo "Running $sql_file..."
	SQL_QUERY=$(cat queries/$sql_file | \
		sed "s/\$BIGQUERY_EXPORT_PROJECT\.\$BIGQUERY_EXPORT_DATASET/$BIGQUERY_EXPORT_PROJECT\.$BIGQUERY_EXPORT_DATASET/")
	destination_csv_file="results/$(echo $sql_file | sed 's/\.sql/\.csv/')"

	echo "$SQL_QUERY" | bq --project_id "$BIGQUERY_EXPORT_PROJECT" query -q --format=csv --use_legacy_sql=false --max_rows=100000000 > $destination_csv_file
done
echo "All queries done!"
