#!/usr/bin/env sh

set -eux

ORGANIZATION_ID="$1"
SNAPSHOT_TIME="$2"

DOCKER_TAG=${ORGANIZATION_ID}-$(echo "$SNAPSHOT_TIME" | sed 's/[:-]//g')
DOCKER_IMAGE="gcp-resources-neo4j:$DOCKER_TAG"

echo "Building image $DOCKER_IMAGE"
sudo docker build . -t $DOCKER_IMAGE && \
sudo docker run --rm -i -t \
	-p 7474:7474 \
	-p 7687:7687 \
	--name gcp_resources_neo4j \
	$DOCKER_IMAGE
