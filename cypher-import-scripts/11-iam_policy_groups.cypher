LOAD CSV WITH HEADERS FROM "file:///iam_policy-groups.csv" AS row
MERGE (g :Group :Account {
    email: row.email
})
ON CREATE SET
    g.email = row.email;