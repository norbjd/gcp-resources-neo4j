// return all UnmanagedServiceAccount (filter Google managed accounts)
MATCH (n:UnmanagedServiceAccount)
WHERE
    NOT n.email =~ ".*@system.gserviceaccount.com"
    AND NOT n.email =~ ".*@cloudservices.gserviceaccount.com"
    AND NOT n.email =~ ".*@cloudbuild.gserviceaccount.com"
    AND NOT n.email =~ "[fp][0-9]*-[0-9a-z]*@gcp-sa-.*.iam.gserviceaccount.com"
    AND NOT n.email =~ "project-[0-9]*@storage-transfer-service.iam.gserviceaccount.com"
    AND NOT n.email =~ ".*@firebase-sa-management.iam.gserviceaccount.com"
    AND NOT n.email =~ ".*@bigquery-data-connectors.iam.gserviceaccount.com"
    AND NOT n.email =~ "service-[0-9]*@.*iam.gserviceaccount.com" // can lead to false negatives
RETURN n;