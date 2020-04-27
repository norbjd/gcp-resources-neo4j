// UnmanagedServiceAccount means "does not belong to a project under the organization"
// most remarkable examples are :
// - Google robot service accounts
// - service accounts from other organizations
// - service accounts that have been removed but still have IAM roles
// - service accounts that do not have any role on resources stored in the graph
LOAD CSV WITH HEADERS FROM "file:///iam_policy-service_accounts.csv" AS row
MERGE (sa :ServiceAccount :Account {
    email: row.email
})
ON CREATE SET
    sa: UnmanagedServiceAccount,
    sa.email = row.email;