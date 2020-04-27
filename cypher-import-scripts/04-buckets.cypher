LOAD CSV WITH HEADERS FROM "file:///resource-bucket.csv" AS row
CREATE (b: Bucket {
    id: row.id,
    storageClass: row.storageClass,
    timeCreated: row.timeCreated,
    bucketPolicyOnlyLocked: row.bucketPolicyOnlyLocked,
    location: row.location
})
MERGE (p: Project {projectNumber: row.projectNumber})
MERGE (b)-[:IS_RESOURCE_OF]->(p);