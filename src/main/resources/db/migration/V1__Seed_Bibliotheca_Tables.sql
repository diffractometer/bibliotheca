INSERT INTO Genres (name)
VALUES ('Fantasy'),
       ('Self-Help'),
       ('Art'),
       ('Design'),
       ('Horror'),
       ('Science Fiction'),
       ('Non-Fiction'),
       ('Mystery'),
       ('Biography'),
       ('History'),
       ('Children’s Literature'),
       ('Young Adult'),
       ('Classics'),
       ('Poetry'),
       ('Drama'),
       ('Philosophy'),
       ('Science'),
       ('Health & Fitness'),
       ('Business'),
       ('Cookbooks'),
       ('Travel'),
       ('Humor'),
       ('Romance'),
       ('Thriller'),
       ('Literary Fiction'),
       ('Graphic Novels'),
       ('Education'),
       ('Politics'),
       ('Cultural Studies'),
       ('Religion'),
       ('Sports'),
       ('Music'),
       ('Law'),
       ('Psychology'),
       ('Technology'),
       ('True Crime'),
       ('Crafts & Hobbies'),
       ('Guide / How-to');

INSERT INTO Books (title, author, genre_id, cell, position)
VALUES ('Naked Empire', 'Terry Goodkind', (SELECT id FROM Genres WHERE name = 'Fantasy'), 1, 1),
       ('The Dance of Anger', 'Harriet Lerner', (SELECT id FROM Genres WHERE name = 'Self-Help'), 1, 2),
       ('Sex', 'Madonna', (SELECT id FROM Genres WHERE name = 'Art'), 1, 3),
       ('Design of the 20th Century', 'Charlotte & Peter Fiell', (SELECT id FROM Genres WHERE name = 'Design'), 1, 4),
       ('11/22/63', 'Stephen King', (SELECT id FROM Genres WHERE name = 'Science Fiction'), 1, 5),
       ('Gödel, Escher, Bach', 'Douglas Hofstadter', (SELECT id FROM Genres WHERE name = 'Science'), 1, 6),
       ('The Selfish Gene', 'Richard Dawkins', (SELECT id FROM Genres WHERE name = 'Science'), 1, 7),
       ('The Wind-Up Bird Chronicle', 'Haruki Murakami', (SELECT id FROM Genres WHERE name = 'Fiction'), 1, 8),
       ('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', (SELECT id FROM Genres WHERE name = 'History'), 2, 1),
       ('The Master and Margarita', 'Mikhail Bulgakov', (SELECT id FROM Genres WHERE name = 'Classics'), 2, 2),
       ('The Man Who Mistook His Wife for a Hat', 'Oliver Sacks', (SELECT id FROM Genres WHERE name = 'Psychology'), 2, 3),
       ('Infinite Jest', 'David Foster Wallace', (SELECT id FROM Genres WHERE name = 'Literary Fiction'), 2, 4),
       ('Gravitys Rainbow', 'Thomas Pynchon', (SELECT id FROM Genres WHERE name = 'Literary Fiction'), 2, 5),
       ('House of Leaves', 'Mark Z. Danielewski', (SELECT id FROM Genres WHERE name = 'Horror'), 2, 6),
       ('I, Robot ', 'Isaac Asimov', (SELECT id FROM Genres WHERE name = 'Science Fiction'), 2, 7),
       ('Meditations', 'Marcus Aurelius', (SELECT id FROM Genres WHERE name = 'Philosophy'), 2, 8),
       ('Foucault’s Pendulum', 'Umberto Eco', (SELECT id FROM Genres WHERE name = 'Fiction'), 3, 1),
       ('A Brief History of Time', 'Stephen Hawking', (SELECT id FROM Genres WHERE name = 'Science'), 3, 2),
       ('The Pale King', 'David Foster Wallace', (SELECT id FROM Genres WHERE name = 'Literary Fiction'), 3, 3),
       ('Atlas Shrugged', 'Ayn Rand', (SELECT id FROM Genres WHERE name = 'Fiction'), 3, 4),
       ('The Black Swan', 'Nassim Nicholas Taleb', (SELECT id FROM Genres WHERE name = 'Economics'), 3, 5),
       ('The Name of the Rose', 'Umberto Eco', (SELECT id FROM Genres WHERE name = 'Mystery'), 3, 6),
       ('The Structure of Scientific Revolutions', 'Thomas S. Kuhn', (SELECT id FROM Genres WHERE name = 'Science'), 3, 7),
       ('Lolita', 'Vladimir Nabokov', (SELECT id FROM Genres WHERE name = 'Classics'), 3, 8);

