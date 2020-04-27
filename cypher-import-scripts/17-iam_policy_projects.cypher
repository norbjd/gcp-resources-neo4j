LOAD CSV WITH HEADERS FROM "file:///iam_policy-project.csv" AS row
MERGE (a: Account {
    email: row.email
})
MERGE (p: Project {
    projectNumber: row.projectNumber
})
MERGE (a)-[:HAS_DIRECT_ROLE {role: row.role}]->(p);