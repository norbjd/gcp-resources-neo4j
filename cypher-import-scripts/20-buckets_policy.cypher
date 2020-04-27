LOAD CSV WITH HEADERS FROM "file:///iam_policy-bucket.csv" AS row
WITH row
WHERE row.accountType <> "specialGroup"
MERGE (b: Bucket {id: row.id})
MERGE (a: Account {email: row.account})
CREATE (a)-[:HAS_DIRECT_ROLE{role: row.role}]->(b);

LOAD CSV WITH HEADERS FROM "file:///iam_policy-bucket.csv" AS row
WITH row
WHERE
    row.accountType = "specialGroup" AND
    row.account STARTS WITH "project" // projectOwner, projectEditor or projectViewer
WITH
    row.id AS bucketId,
    row.role AS role,
    row.account AS specialGroup,
    SPLIT(row.account, ":")[1] AS projectId,
    "roles/" + TOLOWER(SUBSTRING(SPLIT(row.account, ":")[0], 7)) AS projectRole
MATCH
    (b: Bucket {id: bucketId}),
    (a: Account)-[r:HAS_DIRECT_ROLE{role: projectRole}]->(p: Project)<-[:IS_RESOURCE_OF]-(b)
WHERE p.id = projectId
CREATE (a)-[:HAS_INDIRECT_ROLE{
    role: role,
    reason: "Special group " + specialGroup
}]->(b);

LOAD CSV WITH HEADERS FROM "file:///iam_policy-bucket.csv" AS row
WITH row
WHERE
    row.accountType = "specialGroup" AND
    (row.account = "allUsers" OR row.account = "allAuthenticatedUsers")
MERGE (g: SpecialGroup :Group :Account{
    email: row.account
})
MERGE (g)-[:HAS_ROLE {role: row.role}]->(b: Bucket {id: row.id});