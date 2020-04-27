LOAD CSV WITH HEADERS FROM "file:///resource-organization.csv" AS row
CREATE (o: Organization {
    id: row.id,
    name: row.name,
    displayName: row.displayName,
    creationTime: row.creationTime,
    ownerDirectoryCustomerId: row.ownerDirectoryCustomerId
});