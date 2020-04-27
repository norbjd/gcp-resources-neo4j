LOAD CSV WITH HEADERS FROM "file:///resource-custom_role.csv" AS row
MATCH (a)-[role: HAS_DIRECT_ROLE | :HAS_INDIRECT_ROLE]->()
WHERE
    a: Account AND
    role.role = row.role
SET
    role.type = "custom",
    role.permissions = SPLIT(row.permissions, ";");