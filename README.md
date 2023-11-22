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
Run the scripts in the following order to seed the database:
```
./lib/run_migration.sh
```

## Make your DB
Run the scripts in the following order to build the insert statements
```
./lib/process_images.sh
./lib/format_csv.sh
./lib/build_inserts.sh
```

At this point, you will have set up the database schema for `Genres` and `Books` and populated the `Books` table with data processed from images.

## Repository File Structure
```
.
├── README.md
├── docker-compose.yml
├── lib
│   ├── build_inserts.sh
│   ├── format_csv.sh
│   ├── presign_url.sh
│   ├── process_images.sh
│   ├── run_migration.sh
│   ├── sync_to_s3.sh
│   └── test_openai.sh
└── src
    ├── main
    │   └── resources
    │       ├── db
    │       │   └── migration
    │       │       ├── V1__Create_Bibliotheca_Tables.sql
    │       │       └── V1__Seed_Bibliotheca_Tables.sql
    │       └── sql
    │           └── queries
    │               ├── V1__Add_books.sql
    │               └── V1__Generate_packing_manifest.sql
    └── test
        └── resources
            ├── bookshelf_cells
            │   ├── 01.png
            │   └── 47577FAA-4AE7-43BE-A075-F1544A5E3B74_1_102_o.jpeg
            └── csv
                └── books_2023-11-19_18-15-07_A0FD.csv
```

## System Instructions
- **Database**: Set up the schema for `Genres` and `Books`.
- **Photos**: Label each cell and enter book data.
- **UI**: Add, sort, and filter books.
- **Import/Export**: Use functionalities as needed.
- **Packing/Unpacking**: Generate lists using cell numbers.
- **Extras**: Implement barcode scanning and cloud sync.
```
