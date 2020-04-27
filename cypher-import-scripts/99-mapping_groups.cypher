LOAD CSV WITH HEADERS FROM "file:///mapping_groups.csv" AS row
MATCH (group :Group :Account {
    email: row.group
})
WITH row, group
MERGE (user :User :Account {
    email: row.user
})
ON CREATE SET
    user.email = row.user
MERGE (user)-[:IS_MEMBER_OF]->(group);