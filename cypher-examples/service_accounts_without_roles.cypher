// be careful, it may have permissions on resource not present in Neo4j
MATCH (sa: ServiceAccount)
WHERE NOT (sa)-[:HAS_DIRECT_ROLE]->()
RETURN sa;