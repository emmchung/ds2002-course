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