MATCH
    (u: User)-[m:IS_MEMBER_OF]->(g: Group),
    (u)-[user_role:HAS_DIRECT_ROLE]->(x),
    (g)-[group_role:HAS_DIRECT_ROLE]->(x)
WHERE user_role.role = group_role.role
RETURN u, m, g, user_role, group_role, x;