LOAD CSV WITH HEADERS FROM "file:///resource-folder.csv" AS row
MERGE (f: Folder {id: row.id})
ON CREATE SET
    f.id = row.id,
    f.name = row.name,
    f.displayName = row.displayName
WITH row, f
MATCH (parent)
WHERE ((parent: Organization) OR (parent: Folder)) AND parent.name = row.parent
CREATE (f)-[:HAS_PARENT]->(parent);