LOAD CSV WITH HEADERS FROM "file:///iam_policy-dataset.csv" AS row
WITH row
WHERE row.accountType <> "specialGroup"
MERGE (d: Dataset {id: row.projectId + ":" + row.datasetId})
MERGE (a: Account {email: row.account})
CREATE (a)-[:HAS_DIRECT_ROLE{role: row.role}]->(d);

LOAD CSV WITH HEADERS FROM "file:///iam_policy-dataset.csv" AS row
WITH row
WHERE
    row.accountType = "specialGroup" AND
    row.account STARTS WITH "project" // projectOwner, projectEditor or projectViewer
WITH
    row.projectId + ":" + row.datasetId AS datasetId,
    row.role AS role,
    row.account AS specialGroup,
    SPLIT(row.account, ":")[1] AS projectId,
    "roles/" + TOLOWER(SUBSTRING(SPLIT(row.account, ":")[0], 7)) AS projectRole
MATCH
    (d: Dataset {id: datasetId}),
    (a: Account)-[r:HAS_DIRECT_ROLE{role: projectRole}]->(p: Project)<-[:IS_RESOURCE_OF]-(d)
WHERE p.id = projectId
CREATE (a)-[:HAS_INDIRECT_ROLE{
    role: role,
    reason: "Special group " + specialGroup
}]->(d);

LOAD CSV WITH HEADERS FROM "file:///iam_policy-dataset.csv" AS row
WITH row
WHERE
    row.accountType = "specialGroup" AND
    (row.account = "allUsers" OR row.account = "allAuthenticatedUsers")
MERGE (g: SpecialGroup :Group :Account{
    email: row.account
})
MERGE (g)-[:HAS_ROLE {role: row.role}]->(d: Dataset {id:row.projectId + ":" + row.datasetId});