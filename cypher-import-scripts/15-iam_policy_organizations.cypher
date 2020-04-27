LOAD CSV WITH HEADERS FROM "file:///iam_policy-organization.csv" AS row
MERGE (a: Account {
    email: row.email
})
MERGE (o: Organization {
    id: row.organizationId
})
MERGE (a)-[:HAS_DIRECT_ROLE {role: row.role}]->(o);
