docker exec -it bibliotheca_db mkdir -p /tmp/migrations

docker cp /Users/hunterhusar/Code/bibliotheca/src/main/resources/db/migration/V1__Create_Bibliotheca_Tables.sql bibliotheca_db:/tmp/migrations/
docker cp /Users/hunterhusar/Code/bibliotheca/src/main/resources/db/migration/V1__Seed_Bibliotheca_Tables.sql bibliotheca_db:/tmp/migrations/

docker exec -it bibliotheca_db psql -U postgres -d bibliotheca_development -a -f /tmp/migrations/V1__Create_Bibliotheca_Tables.sql
docker exec -it bibliotheca_db psql -U postgres -d bibliotheca_development -a -f /tmp/migrations/V1__Seed_Bibliotheca_Tables.sql
