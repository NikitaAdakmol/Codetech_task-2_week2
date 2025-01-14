--Task-1
-- Create the Database

CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

-- Create 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique student identifier
    first_name VARCHAR(100) NOT NULL,            -- First name of the student
    last_name VARCHAR(100) NOT NULL,             -- Last name of the student
    email VARCHAR(100) UNIQUE NOT NULL,          -- Email address of the student
    phone_number VARCHAR(15),                    -- Phone number of the student
    date_of_birth DATE,                          -- Date of birth of the student
    enrollment_date DATE NOT NULL                -- Enrollment date
);

-- Create 'courses' table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique course identifier
    course_name VARCHAR(255) NOT NULL,           -- Name of the course
    course_code VARCHAR(10) UNIQUE NOT NULL,    -- Course code
    instructor_name VARCHAR(255) NOT NULL,      -- Instructor name
    credits INT NOT NULL                        -- Number of credits for the course
);

-- Create 'enrollments' table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique enrollment identifier
    student_id INT,                                 -- Foreign key referring to students
    course_id INT,                                  -- Foreign key referring to courses
    enrollment_date DATE NOT NULL,                  -- Date of enrollment
    grade VARCHAR(2),                               -- Grade obtained by the student
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create 'exams' table
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,    -- Unique exam identifier
    course_id INT,                              -- Foreign key referring to courses
    exam_date DATE NOT NULL,                    -- Date of the exam
    total_marks INT NOT NULL,                   -- Total marks of the exam
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
-- Insert data into 'students' table
INSERT INTO students (first_name, last_name, email, phone_number, date_of_birth, enrollment_date)
VALUES 
('John', 'Doe', 'johndoe@example.com', '555-123-4567', '1999-05-15', '2021-09-01'),
('Jane', 'Smith', 'janesmith@example.com', '555-987-6543', '2000-08-22', '2022-02-01'),
('Alice', 'Johnson', 'alicej@example.com', '555-234-5678', '1998-11-10', '2021-10-15'),
('Bob', 'Martin', 'bobmartin@example.com', '555-345-6789', '2001-01-30', '2023-01-10');

-- Insert data into 'courses' table
INSERT INTO courses (course_name, course_code, instructor_name, credits)
VALUES 
('Computer Science 101', 'CS101', 'Dr. Smith', 3),
('Mathematics 101', 'MATH101', 'Dr. Johnson', 4),
('History 101', 'HIST101', 'Dr. Lee', 3),
('English 101', 'ENG101', 'Dr. Brown', 3);

-- Insert data into 'enrollments' table
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES 
(1, 1, '2021-09-01', 'A'),
(1, 2, '2021-09-01', 'B'),
(2, 3, '2022-02-01', 'A'),
(3, 1, '2021-10-15', 'C'),
(4, 4, '2023-01-10', 'B');

-- Insert data into 'exams' table
INSERT INTO exams (course_id, exam_date, total_marks)
VALUES 
(1, '2022-05-15', 100),
(2, '2022-05-17', 100),
(3, '2022-05-20', 100),
(4, '2023-05-01', 100);

-- INNER JOIN: Get all students with their enrolled courses
SELECT s.first_name, s.last_name, c.course_name, e.enrollment_date, e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

#Update Student's Grade in a Course
UPDATE enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id
SET e.grade = 'A'
WHERE s.first_name = 'John' AND s.last_name = 'Doe' AND c.course_name = 'Data Structures';


-- LEFT JOIN: Get all courses and their enrolled students (if any)
SELECT c.course_name, s.first_name, s.last_name, e.enrollment_date
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN students s ON e.student_id = s.student_id;


-- RIGHT JOIN: Get all students and their enrolled courses (if any)
SELECT s.first_name, s.last_name, c.course_name, e.enrollment_date
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;


-- FULL OUTER JOIN (Simulated): Get all students and all courses with enrollments
SELECT s.first_name, s.last_name, c.course_name, e.enrollment_date
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
UNION
SELECT s.first_name, s.last_name, c.course_name, e.enrollment_date
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;
