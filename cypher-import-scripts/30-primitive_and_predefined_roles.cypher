LOAD CSV WITH HEADERS FROM "file:///primitive_and_predefined_roles.csv" AS row
MATCH (a)-[role: HAS_DIRECT_ROLE | :HAS_INDIRECT_ROLE]->()
WHERE
    a: Account AND
    role.role = row.role
SET
    role.type = 
        CASE
        WHEN role.role = "roles/owner" OR role.role = "roles/editor" OR role.role = "roles/viewer" THEN "primitive"
        ELSE "predefined"
        END,
    role.permissions = SPLIT(row.permissions, ";");