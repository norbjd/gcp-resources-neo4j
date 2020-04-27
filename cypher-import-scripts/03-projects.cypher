LOAD CSV WITH HEADERS FROM "file:///resource-project.csv" AS row
MERGE (p: Project {id: row.id})
ON CREATE SET
    p.projectNumber = row.projectNumber,
    p.name = row.name,
    p.createTime = row.createTime
WITH row, p
MATCH (parent)
WHERE ((parent: Organization) OR (parent: Folder)) AND parent.name = row.parentId
MERGE (p)-[:HAS_PARENT]->(parent);