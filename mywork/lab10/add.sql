USE mkt3qv_db;

INSERT INTO authors (author_id, author_name, country, birth_year)
VALUES
(11, 'Author A', 'USA', 1990),
(12, 'Author B', 'UK', 1985),
(13, 'Author C', 'Canada', 1975);

INSERT INTO books (book_id, title, genre, publish_year, author_id)
VALUES
(111, 'Book A', 'Fiction', 2000, 11),
(112, 'Book B', 'Fiction', 2005, 12);
