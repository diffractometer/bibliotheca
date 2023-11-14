CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS Books CASCADE;
DROP TABLE IF EXISTS Genres CASCADE;

CREATE TABLE Genres
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Books
(
    id       UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Unique identifier for each book
    title    VARCHAR(255) NOT NULL,                       -- Title of the book
    author   VARCHAR(255) NOT NULL,                       -- Author of the book
    genre_id INT REFERENCES Genres (id),                  -- Foreign key to the genre
    cell     INT NOT NULL,                                -- Sequential cell number across all shelves
    position INT NOT NULL                                 -- Position within a cell (1-8)
);

ALTER TABLE Books ADD CONSTRAINT chk_cell CHECK (cell BETWEEN 1 AND 40);
ALTER TABLE Books ADD CONSTRAINT chk_position CHECK (position BETWEEN 1 AND 8);