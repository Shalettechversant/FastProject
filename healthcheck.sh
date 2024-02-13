#!/bin/bash

until pg_isready -h postgres -p 5432 -U postgres; do
    echo "PostgreSQL is unavailable - sleeping"
    sleep 1
done

echo "PostgreSQL is up - executing command"
exec "$@"
