LOAD CSV WITH HEADERS FROM "file:///iam_policy-folder.csv" AS row
MERGE (a: Account {
    email: row.email
})
MERGE (f: Folder {
    id: row.folderId
})
MERGE (a)-[:HAS_DIRECT_ROLE {role: row.role}]->(f);
