LOAD CSV WITH HEADERS FROM "file:///iam_policy-users.csv" AS row
MERGE (u :User :Account {
    email: row.email
})
ON CREATE SET
    u.email = row.email;