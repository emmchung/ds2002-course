USE mkt3qv_db;

SELECT 
    b.book_id,
    b.title,
    b.genre,
    b.publish_year,
    a.author_name,
    a.country
FROM books b
JOIN authors a
    ON b.author_id = a.author_id
WHERE b.publish_year >= 1950
ORDER BY b.publish_year DESC;
