#!/bin/bash
set -e
echo "*************************** IN ENV DIR **************************";

export EXPORT_DIR="/SymmetricdsApp/ExportDir"

mkdir -p $EXPORT_DIR

# Path to SymmetricDS
export SYM_HOME="/SymmetricdsApp/symmetricds"
export PATH=$PATH:$SYM_HOME/bin

envsubst < /SymmetricdsApp/symmetricds/engines/pg.properties.template > /SymmetricdsApp/symmetricds/engines/pg.properties
envsubst < /SymmetricdsApp/symmetricds/engines/sqlite.properties.template > /SymmetricdsApp/symmetricds/engines/sqlite.properties

PG_URL=$(echo "$URL_DB" | sed -E 's/^jdbc://')

# Add credentials from env (POSTGRES_USER, POSTGRES_PASSWORD)
export PSQL_URL="${PG_URL}?user=${DB_USER}&password=${DB_PASSWORD}"

echo "Connecting with: $PSQL_URL"