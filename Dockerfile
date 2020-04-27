FROM    neo4j:3.5.9

ENV     NEO4J_AUTH=neo4j/password

COPY    cypher-import-scripts/*.cypher results/*.csv /var/lib/neo4j/import/

USER    neo4j

RUN     echo "dbms.directories.data=/tmp" >> /var/lib/neo4j/conf/neo4j.conf \
 &&     bin/neo4j-admin set-initial-password password || true \
 &&     bin/neo4j start \
 &&     sleep 10 \
 &&     for cypher_file in $(find /var/lib/neo4j/import/* -name '*.cypher' | sort); \
        do \
                echo ">> Running $cypher_file :" && \
                cat $cypher_file && echo && \
                cat $cypher_file | \
                    NEO4J_USERNAME=neo4j NEO4J_PASSWORD=password \
                    /var/lib/neo4j/bin/cypher-shell --debug --format=verbose || exit 1; \
        done