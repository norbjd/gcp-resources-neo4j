LOAD CSV WITH HEADERS FROM "file:///resource-dataset.csv" AS row
MERGE (d: Dataset {id: row.id})
ON CREATE SET
    d.id = row.id,
    d.datasetId = row.datasetId,
    d.location = row.location
MERGE (p: Project {id: row.projectId})
MERGE (d)-[:IS_RESOURCE_OF]->(p);