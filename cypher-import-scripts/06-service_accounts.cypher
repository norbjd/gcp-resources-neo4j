LOAD CSV WITH HEADERS FROM "file:///resource-serviceaccount.csv" AS row
MERGE (sa :ServiceAccount :Account {
    id: row.id
})
ON CREATE SET
    sa.id = row.id,
    sa.email = row.email,
    sa.displayName = row.displayName
MERGE (p: Project {
    id: row.projectId
})
MERGE (sa)-[:IS_RESOURCE_OF]->(p);