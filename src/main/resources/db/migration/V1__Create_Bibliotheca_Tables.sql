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
    id       UUID PRIMARY KEY      DEFAULT uuid_generate_v4(), -- Unique identifier for each book
    title    VARCHAR(255) NULL,                                -- Title of the book
    author   VARCHAR(255) NULL,                                -- Author of the book
    genre_id INT REFERENCES Genres (id) NULL,                  -- Foreign key to the genre
    cell     INT          NULL,                                -- Sequential cell number across all shelves
    position INT          NULL,                                -- Position within a cell (1-X)
    verified BOOLEAN      NOT NULL DEFAULT FALSE,              -- Indicates if the book entry has been verified
    cover_image_s3_url VARCHAR(255) NULL,                      -- URL to the book's cover image stored in S3
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),              -- Timestamp of record creation
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE ProcessedImages
(
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Unique identifier for each processed image entry
    image_key    VARCHAR(255) UNIQUE NOT NULL,                -- The key or URL of the processed image
    processed_at TIMESTAMP NOT NULL DEFAULT NOW()             -- Timestamp of when the image was processed
);

-- ALTER TABLE Books ADD CONSTRAINT chk_cell CHECK (cell BETWEEN 1 AND 40); -- Adjust for number of shelves
-- ALTER TABLE Books ADD CONSTRAINT chk_position CHECK (position BETWEEN 1 AND 8); -- Adjust for shelf size
