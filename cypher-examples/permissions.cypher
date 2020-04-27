MATCH
    (a: Account)-[r:HAS_DIRECT_ROLE]->(x)
WHERE "storage.objects.get" IN r.permissions
RETURN a, r, x;

# this syntax is required where looking for permissions
# matching a specific regex
MATCH
    (a: Account)-[r:HAS_DIRECT_ROLE]->(x)
WHERE
    ANY(p IN r.permissions WHERE p =~ "storage\\..*")
RETURN a, r, x;
