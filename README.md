# Bibliotheca

## PostgreSQL Commands
```sql
DROP DATABASE IF EXISTS bibliotheca_development;
CREATE DATABASE bibliotheca_development;
```

## Docker Commands
- Start container: `docker-compose up -d`
- Connect: `docker exec -it bibliotheca_db psql -U postgres -d bibliotheca_development`

## Seed Data
Run the script to seed the database:
```
./lib/run_migration.sh
```

## Repository File Structure
```
src/
├── main/
│   ├── resources/
│       ├── db/
│           ├── migration/
│               ├── V1__Create_Bibliotheca_Tables.sql
│               ├── V1__Seed_Bibliotheca_Tables.sql
│       ├── sql/
│           ├── queries/
│               ├── V1__Add_books.sql
│               ├── V2__Insert_example_book.sql
│               ├── packing_rule.sql
```

## System Instructions
- **Database**: Set up the schema for `Genres` and `Books`.
- **Photos**: Label each cell and enter book data.
- **UI**: Add, sort, and filter books.
- **Import/Export**: Use functionalities as needed.
- **Packing/Unpacking**: Generate lists using cell numbers.
- **Extras**: Implement barcode scanning and cloud sync.

