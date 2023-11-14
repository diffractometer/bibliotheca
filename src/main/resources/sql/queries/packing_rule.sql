-- organized_unpacking_plan.sql

WITH GenreOrder AS (
    SELECT id, name, ROW_NUMBER() OVER (ORDER BY name) AS genre_order
    FROM Genres
),
     BooksWithGenreOrder AS (
         SELECT
             B.id,
             B.title,
             B.author,
             B.genre_id,
             GO.genre_order,
             ROW_NUMBER() OVER (PARTITION BY B.genre_id ORDER BY B.author, B.title) AS book_order_within_genre
         FROM Books B
                  JOIN GenreOrder GO ON B.genre_id = GO.id
     ),
     PackedBooks AS (
         SELECT
             BGO.id,
             BGO.title,
             BGO.author,
             BGO.genre_id,
             BGO.genre_order,
             BGO.book_order_within_genre,
             -- Calculate the cell based on the genre order and the order of the book within the genre
             -- Assuming 8 books per cell
             CEILING((CAST(ROW_NUMBER() OVER (ORDER BY BGO.genre_order, BGO.author, BGO.title) AS DECIMAL)) / 8) AS cell,
             -- Calculate the position in the cell
             (ROW_NUMBER() OVER (ORDER BY BGO.genre_order, BGO.author, BGO.title) - 1) % 8 + 1 AS position
         FROM BooksWithGenreOrder BGO
     )
SELECT
    PB.title,
    PB.author,
    (SELECT name FROM Genres WHERE id = PB.genre_id) AS genre_name,
    PB.cell AS CellNumber,
    PB.position AS PositionInCell
FROM
    PackedBooks PB
ORDER BY
    PB.cell, PB.position;
