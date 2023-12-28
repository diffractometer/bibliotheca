-- SELECT b.*, g.name AS genre_name
-- FROM books b
-- INNER JOIN genres g ON b.genre_id = g.id
-- ORDER BY g.name ASC, b.title ASC;

SELECT b.*, g.name AS genre_name
FROM books b
         INNER JOIN genres g ON b.genre_id = g.id
WHERE g.id = ? -- the parameter for genre_id goes here
ORDER BY g.name ASC, b.title ASC;