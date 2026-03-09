
DROP DATABASE IF EXISTS lab5_demo;
CREATE DATABASE lab5_demo;
USE lab5_demo;

DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  computing_id VARCHAR(20) NOT NULL UNIQUE,
  full_name VARCHAR(100) NOT NULL,
  class_year INT NOT NULL
);

DROP TABLE IF EXISTS study_sessions;
CREATE TABLE study_sessions (
  session_id INT PRIMARY KEY,
  student_id INT NOT NULL,
  topic VARCHAR(100) NOT NULL,
  minutes INT NOT NULL,
  session_time DATETIME NOT NULL,
  CONSTRAINT fk_study_student
    FOREIGN KEY (student_id) REFERENCES students(student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE

INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (1,  'abc1d', 'Ava Brown',    2026);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (2,  'cde2f', 'Carlos Diaz',  2025);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (3,  'efg3h', 'Emma Green',   2027);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (4,  'ghi4j', 'Grace Hill',   2026);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (5,  'ijk5l', 'Ishan Kumar',  2024);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (6,  'klm6n', 'Kai Liu',      2025);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (7,  'mno7p', 'Maya Nguyen',  2026);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (8,  'opq8r', 'Omar Patel',   2027);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (9,  'qrs9t', 'Quinn Smith',  2024);
INSERT INTO students (student_id, computing_id, full_name, class_year) VALUES (10, 'stu0v', 'Sofia Torres', 2025);

INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (101, 1,  'SQL scripts',          45, '2026-02-10 18:00:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (102, 2,  'ETL pipelines',        60, '2026-02-11 19:30:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (103, 3,  'MySQL joins',          35, '2026-02-12 16:15:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (104, 4,  'Primary keys',         25, '2026-02-12 20:05:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (105, 5,  'Foreign keys',         50, '2026-02-13 14:00:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (106, 6,  'Python mysql-connector',40, '2026-02-14 11:20:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (107, 7,  'WHERE filters',        30, '2026-02-14 21:10:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (108, 8,  'GROUP BY basics',      55, '2026-02-15 09:45:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (109, 9,  'Debugging SQL',        20, '2026-02-15 17:05:00');
INSERT INTO study_sessions (session_id, student_id, topic, minutes, session_time) VALUES (110, 10, 'Lab submission prep',  65, '2026-02-16 13:30:00');
=======
DROP DATABASE IF EXISTS mkt3qv_db;
CREATE DATABASE mkt3qv_db;
USE mkt3qv_db;

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    birth_year INT
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    publish_year INT,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO authors (author_id, author_name, country, birth_year) VALUES
(1, 'Toni Morrison', 'United States', 1931),
(2, 'Gabriel Garcia Marquez', 'Colombia', 1927),
(3, 'Jane Austen', 'United Kingdom', 1775),
(4, 'Chinua Achebe', 'Nigeria', 1930),
(5, 'Haruki Murakami', 'Japan', 1949),
(6, 'Margaret Atwood', 'Canada', 1939),
(7, 'George Orwell', 'United Kingdom', 1903),
(8, 'Isabel Allende', 'Chile', 1942),
(9, 'Kazuo Ishiguro', 'United Kingdom', 1954),
(10, 'Octavia Butler', 'United States', 1947);

INSERT INTO books (book_id, title, genre, publish_year, author_id) VALUES
(101, 'Beloved', 'Fiction', 1987, 1),
(102, 'Song of Solomon', 'Fiction', 1977, 1),
(103, 'One Hundred Years of Solitude', 'Magical Realism', 1967, 2),
(104, 'Love in the Time of Cholera', 'Romance', 1985, 2),
(105, 'Pride and Prejudice', 'Romance', 1813, 3),
(106, 'Things Fall Apart', 'Historical Fiction', 1958, 4),
(107, 'Kafka on the Shore', 'Magical Realism', 2002, 5),
(108, 'The Handmaid''s Tale', 'Dystopian', 1985, 6),
(109, '1984', 'Dystopian', 1949, 7),
(110, 'Kindred', 'Science Fiction', 1979, 10);

