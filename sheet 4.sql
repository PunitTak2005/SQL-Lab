-- Create the database named 'L'
CREATE DATABASE L;

-- Switch to the 'L' database
USE L;

-- STEP 1: Create the Department table without the HeadedBy constraint
-- The 'DepartmentName' is the primary key.
-- The 'HeadedBy' column is added but will have a foreign key constraint later.
CREATE TABLE Department (
    DepartmentName VARCHAR(50) PRIMARY KEY,  -- Primary key for department name
    Location VARCHAR(50),                   -- Department location
    HeadedBy VARCHAR(50)                    -- Will reference Instructor's name later
);

-- STEP 2: Create the Instructor table
-- The 'InstructorName' is the primary key.
-- The 'DepartmentName' is a foreign key that links to the 'Department' table.
CREATE TABLE Instructor (
    InstructorName VARCHAR(50) PRIMARY KEY,  -- Primary key for instructor name
    Telephone VARCHAR(15),                  -- Instructor's phone number
    Room VARCHAR(10),                       -- Room assigned to instructor
    DepartmentName VARCHAR(50),             -- Department the instructor belongs to
    FOREIGN KEY (DepartmentName) REFERENCES Department(DepartmentName)  -- Foreign key constraint for Department
);

-- STEP 3: Add the HeadedBy FOREIGN KEY after the Instructor table is created
-- This constraint ensures that the 'HeadedBy' column in the Department table 
-- references a valid instructor name from the Instructor table.
ALTER TABLE Department
ADD CONSTRAINT fk_HeadedBy FOREIGN KEY (HeadedBy) REFERENCES Instructor(InstructorName);

-- STEP 4: Create the Course table
-- The 'Course' column is the primary key, representing course codes.
-- The 'DepartmentName' links the course to a department.
-- The 'Prerequisite' references another course (self-referencing foreign key).
CREATE TABLE Course (
    Course INT PRIMARY KEY,                 -- Course code as the primary key
    CourseName VARCHAR(100),                -- Name of the course
    Duration INT,                           -- Duration of the course in years
    Prerequisite INT,                       -- Course prerequisite (references another course)
    DepartmentName VARCHAR(50),             -- Department offering the course
    FOREIGN KEY (Prerequisite) REFERENCES Course(Course),  -- Self-referencing foreign key for prerequisites
    FOREIGN KEY (DepartmentName) REFERENCES Department(DepartmentName)  -- Foreign key for department
);

-- STEP 5: Create the Student table
-- The 'Student' column is the primary key, representing student IDs.
CREATE TABLE Student (
    Student INT PRIMARY KEY,                -- Student ID as the primary key
    StudentName VARCHAR(100),               -- Student's full name
    DateOfBirth DATE                        -- Student's date of birth
);

-- STEP 6: Create the Enrollment table
-- This table connects students to courses (many-to-many relationship).
-- The primary key is a combination of Student and Course.
CREATE TABLE Enrollment (
    Student INT,                            -- Foreign key for student ID
    Course INT,                             -- Foreign key for course code
    PRIMARY KEY (Student, Course),          -- Composite primary key (Student, Course)
    FOREIGN KEY (Student) REFERENCES Student(Student),  -- Foreign key for student
    FOREIGN KEY (Course) REFERENCES Course(Course)      -- Foreign key for course
);

-- Insert sample data into the Instructor table
-- These records represent instructors, their contact details, assigned departments.
INSERT INTO Instructor (InstructorName, Telephone, Room, DepartmentName) VALUES
('Dr. Strange', '1234567890', 'A101', 'Computer Science'),
('Tony Stark', '2345678901', 'B201', 'Electronics'),
('Bruce Banner', '3456789012', 'C301', 'Physics'),
('Steve Rogers', '4567890123', 'D401', 'History'),
('Natasha Romanoff', '5678901234', 'E501', 'Mathematics'),
('Thor Odinson', '6789012345', 'F601', 'Literature'),
('Wanda Maximoff', '7890123456', 'G701', 'Psychology'),
('Peter Parker', '8901234567', 'H801', 'Biotech'),
('Stephen Hawking', '9012345678', 'I901', 'Astrophysics'),
('Albert Einstein', '1122334455', 'J111', 'Quantum Studies');

-- Insert sample data into the Department table
-- These records represent departments with their locations and head of department.
INSERT INTO Department (DepartmentName, Location, HeadedBy) VALUES
('Computer Science', 'Block A', 'Dr. Strange'),
('Electronics', 'Block B', 'Tony Stark'),
('Physics', 'Block C', 'Bruce Banner'),
('History', 'Block D', 'Steve Rogers'),
('Mathematics', 'Block E', 'Natasha Romanoff'),
('Literature', 'Block F', 'Thor Odinson'),
('Psychology', 'Block G', 'Wanda Maximoff'),
('Biotech', 'Block H', 'Peter Parker'),
('Astrophysics', 'Block I', 'Stephen Hawking'),
('Quantum Studies', 'Block J', 'Albert Einstein');

-- Insert sample data into the Student table
-- These records represent students, their names, and birthdates.
INSERT INTO Student (Student, StudentName, DateOfBirth) VALUES
(201, 'Aryan Sharma', '2003-06-15'),
(202, 'Megha Kapoor', '2002-11-23'),
(203, 'Rohan Gupta', '2004-01-10'),
(204, 'Sneha Rajput', '2003-09-05'),
(205, 'Karan Patel', '2002-02-14'),
(206, 'Pooja Joshi', '2003-03-30'),
(207, 'Ritika Meena', '2001-07-21'),
(208, 'Yash Verma', '2003-10-18'),
(209, 'Simran Singh', '2004-05-06'),
(210, 'Aditya Rathore', '2003-08-08');

-- Insert sample data into the Enrollment table
-- These records represent the enrollment of students in various courses.
INSERT INTO Enrollment (Student, Course) VALUES
(201, 101),
(202, 102),
(203, 103),
(204, 104),
(205, 105),
(206, 106),
(207, 107),
(208, 108),
(209, 109),
(210, 110);


-- Disable foreign key checks to allow the following operations without checking for referential integrity
SET FOREIGN_KEY_CHECKS = 0;

-- Query to select the StudentName and DateOfBirth from the Student table
SELECT StudentName, DateOfBirth
FROM Student;

-- Query to select all details from the Department table where the DepartmentName is 'Computer Science'
SELECT *
FROM Department
WHERE DepartmentName = 'Computer Science';

-- Query to select CourseName and Duration from the Course table
SELECT CourseName, Duration
FROM Course;

-- Inserting new courses into the Course table
INSERT INTO Course (Course, CourseName, Duration, Prerequisite, DepartmentName) VALUES
(201, 'Intro to Programming', 4, NULL, 'Computer Science'),
(202, 'Digital Electronics', 3, NULL, 'Electronics'),
(203, 'Quantum Mechanics', 5, NULL, 'Physics'),
(204, 'World History', 4, NULL, 'History'),
(205, 'Calculus I', 3, NULL, 'Mathematics'),
(206, 'Shakespearean Literature', 4, NULL, 'Literature'),
(207, 'Cognitive Psychology', 4, NULL, 'Psychology'),
(208, 'Genetics', 3, NULL, 'Biotech'),
(209, 'Black Holes and Beyond', 4, 203, 'Astrophysics'),
(210, 'Quantum Field Theory', 5, 203, 'Quantum Studies');

-- Inserting a new instructor into the Instructor table
INSERT INTO Instructor (InstructorName, Telephone, Room, DepartmentName)
VALUES ('Professor X', '9998887776', 'X101', 'Psychology');

-- Updating the Location for the 'Physics' department in the Department table
UPDATE Department
SET Location = 'Building C'
WHERE DepartmentName = 'Physics';

-- Deleting a student with Student ID 101 from the Student table
DELETE FROM Student
WHERE Student = 101;

-- Re-inserting the deleted student into the Student table with new details
INSERT INTO Student (Student, StudentName, DateOfBirth)
VALUES (101, 'Peter Parker', '2001-08-10');

-- Inserting a new course into the Course table for Web Development
INSERT INTO Course (Course, CourseName, Duration, Prerequisite, DepartmentName)
VALUES (221, 'Web Development', 6, NULL, 'Computer Science');

-- Inserting a new enrollment record for the student 'Peter Parker' in the 'Intro to Programming' course
INSERT INTO Enrollment (Student, Course)
VALUES (101, 201);

-- Query to get the StudentName, CourseName, and Course details by joining the Student, Enrollment, and Course tables
SELECT 
    s.StudentName,
    c.CourseName,
    c.Course
FROM 
    Student s
JOIN 
    Enrollment e ON s.Student = e.Student
JOIN 
    Course c ON e.Course = c.Course;

-- Query to get the DepartmentName and CourseName by joining the Department and Course tables
SELECT 
    d.DepartmentName,
    c.CourseName
FROM 
    Department d
JOIN 
    Course c ON d.DepartmentName = c.DepartmentName;

-- Creating a new table 'Teaches' to store the relationship between Instructor and Course
CREATE TABLE Teaches (
    InstructorName VARCHAR(50),
    Course INT,
    FOREIGN KEY (InstructorName) REFERENCES Instructor(InstructorName),
    FOREIGN KEY (Course) REFERENCES Course(Course)
);

-- Inserting data into the Teaches table, specifying which instructor teaches which course
INSERT INTO Teaches (InstructorName, Course) VALUES
('Dr. Strange', 201),
('Tony Stark', 202),
('Bruce Banner', 203),
('Steve Rogers', 204),
('Natasha Romanoff', 205),
('Thor Odinson', 206),
('Wanda Maximoff', 207),
('Peter Parker', 208),
('Stephen Hawking', 209),
('Albert Einstein', 210);

-- Query to get InstructorName, CourseName, and Room by joining the Teaches, Instructor, and Course tables
SELECT 
    i.InstructorName,
    c.CourseName,
    i.Room
FROM 
    Teaches t
JOIN 
    Instructor i ON t.InstructorName = i.InstructorName
JOIN 
    Course c ON t.Course = c.Course;


-- Query to get the CourseName and the number of students enrolled in each course
SELECT 
    c.CourseName,
    COUNT(e.Student) AS NumStudents  -- Counts the number of students per course
FROM 
    Enrollment e
JOIN 
    Course c ON e.Course = c.Course  -- Joins the Enrollment and Course tables on Course ID
GROUP BY 
    c.CourseName;  -- Groups the results by CourseName to get the student count per course

-- Query to get the average course duration per department
SELECT 
    DepartmentName,
    AVG(Duration) AS AvgCourseDuration  -- Calculates the average duration for courses in each department
FROM 
    Course
GROUP BY 
    DepartmentName;  -- Groups the results by DepartmentName to calculate the average duration per department

-- Query to find the instructor who teaches the most number of courses
SELECT 
    InstructorName,
    COUNT(Course) AS CoursesTaught  -- Counts the number of courses taught by each instructor
FROM 
    Teaches
GROUP BY 
    InstructorName  -- Groups the results by InstructorName
ORDER BY 
    CoursesTaught DESC  -- Orders the results by CoursesTaught in descending order (most courses first)
LIMIT 1;  -- Limits the result to only 1, showing the instructor with the highest number of courses

-- Query to get all unique departments that have courses in them
SELECT DISTINCT 
    DepartmentName  -- Retrieves distinct department names (no duplicates)
FROM 
    Course
WHERE 
    DepartmentName IS NOT NULL;  -- Ensures that only departments with courses are included (excluding NULL values)

-- Query to find students whose names start with 'A'
SELECT 
    StudentName
FROM 
    Student
WHERE 
    StudentName LIKE 'A%';  -- Filters the results to show only students whose names start with 'A'

-- Query to find students born before January 1, 2000
SELECT 
    StudentName, DateOfBirth
FROM 
    Student
WHERE 
    DateOfBirth < '2000-01-01';  -- Filters the students whose date of birth is before January 1, 2000

-- Query to find students born before January 1, 2020
SELECT 
    StudentName, DateOfBirth
FROM 
    Student
WHERE 
    DateOfBirth < '2020-01-01';  -- Filters the students whose date of birth is before January 1, 2020

-- Query to find courses with a duration greater than 3 or no prerequisite
SELECT 
    CourseName, Duration, Prerequisite  -- Retrieves the course name, duration, and prerequisite
FROM 
    Course
WHERE 
    Duration > 3 OR Prerequisite IS NULL;  -- Filters courses that either have a duration greater than 3 or no prerequisite

-- Query to find students who are not enrolled in any course
SELECT 
    StudentName
FROM 
    Student
WHERE 
    Student NOT IN (SELECT Student FROM Enrollment);  -- Filters students who do not appear in the Enrollment table

-- Query to get details of courses named 'Mathematics' or 'Physics'
SELECT * 
FROM 
    Course 
WHERE 
    CourseName IN ('Mathematics', 'Physics');  -- Filters courses that have the name 'Mathematics' or 'Physics'

-- Query to get details of departments named 'Mathematics' or 'Physics'
SELECT * 
FROM 
    Department 
WHERE 
    DepartmentName IN ('Mathematics', 'Physics');  -- Filters departments with the name 'Mathematics' or 'Physics'

-- Inserting a new student named 'Aaryan Vyas' with a given date of birth
INSERT INTO Student (Student, StudentName, DateOfBirth)
VALUES (201, 'Aaryan Vyas', '2001-01-01');  -- Inserts a new record into the Student table


-- Insert enrollment data for student 201 in Mathematics (Course 255) and Physics (Course 242)
INSERT INTO Enrollment (Student, Course)
VALUES 
(201, 255),  -- Enrolls student 201 in Mathematics
(201, 242);  -- Enrolls student 201 in Physics

-- Query to find students who are enrolled in both Mathematics and Physics courses
SELECT 
    s.StudentName
FROM 
    Student s
WHERE 
    s.Student IN (
        -- Subquery to find students enrolled in Mathematics
        SELECT e1.Student
        FROM Enrollment e1
        JOIN Course c1 ON e1.Course = c1.Course
        WHERE c1.CourseName = 'Mathematics'
    )
AND 
    s.Student IN (
        -- Subquery to find students enrolled in Physics
        SELECT e2.Student
        FROM Enrollment e2
        JOIN Course c2 ON e2.Course = c2.Course
        WHERE c2.CourseName = 'Physics'
    );

-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS PreventOverlappingEnrollments;

-- Change delimiter to handle multi-line trigger
DELIMITER $$

-- Create a trigger to prevent a student from enrolling in the same course twice
CREATE TRIGGER PreventOverlappingEnrollments
BEFORE INSERT ON Enrollment
FOR EACH ROW
BEGIN
    DECLARE enroll_count INT;

    -- Check if the student is already enrolled in the same course
    SELECT COUNT(*) INTO enroll_count
    FROM Enrollment
    WHERE Student = NEW.Student AND Course = NEW.Course;

    -- If the student is already enrolled, raise an error
    IF enroll_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student already enrolled in this course!';
    END IF;

END$$

-- Reset delimiter
DELIMITER ;

-- Try inserting the same enrollment again; will trigger the error
INSERT INTO Enrollment (Student, Course) VALUES (201, 255);  -- This will raise an error if student 201 is already enrolled in Course 255

-- Create a trigger to set a default room ('101') if no room is provided for an instructor
DELIMITER $$

CREATE TRIGGER SetDefaultRoom
BEFORE INSERT ON Instructor
FOR EACH ROW
BEGIN
    -- If Room is NULL or empty, assign a default room '101'
    IF NEW.Room IS NULL OR NEW.Room = '' THEN
        SET NEW.Room = '101';
    END IF;
END$$

-- Reset delimiter
DELIMITER ;

-- Insert a new instructor without specifying a room, so it defaults to '101'
INSERT INTO Instructor (InstructorName)
VALUES ( 'Punit Sir');  -- 'Punit Sir' will be assigned room '101'

-- Check the Instructor table to see the inserted record
SELECT * FROM Instructor;

-- Query to find departments with more than one course
SELECT DepartmentName, COUNT(Course) AS CourseCount
FROM Course
GROUP BY DepartmentName  -- Groups by DepartmentName
HAVING COUNT(Course) > 1;  -- Filters departments with more than one course

-- Query to find students who are enrolled in more than 2 courses
SELECT Student, COUNT(Course) AS TotalCourses
FROM Enrollment
GROUP BY Student  -- Groups by Student
HAVING COUNT(Course) > 2;  -- Filters students enrolled in more than 2 courses

-- Query to check if a student (with ID 104) is enrolled in any course
SELECT EXISTS(
    SELECT 1  -- Returns 1 if the student is enrolled, else 0
    FROM Enrollment
    WHERE Student = 104
) AS IsEnrolled;

-- Query to find instructors who teach courses with prerequisites (i.e., where the course has a prerequisite)
SELECT DISTINCT i.InstructorName
FROM Instructor i
WHERE EXISTS (
    SELECT 1
    FROM Teaches t
    JOIN Course c ON t.Course = c.Course
    WHERE t.InstructorName = i.InstructorName
    AND c.Prerequisite IS NOT NULL  -- Filters courses with a prerequisite
);

-- Create a view to list all courses along with their department
CREATE VIEW DepartmentWiseCourses AS
SELECT 
    d.DepartmentName,  -- Retrieves the department name
    c.CourseName,      -- Retrieves the course name
    c.Course           -- Retrieves the course ID
FROM 
    Department d
JOIN 
    Course c ON d.DepartmentName = c.DepartmentName;  -- Joins Department and Course on DepartmentName

-- To check if the view was created successfully, retrieve all data from the view
SELECT * FROM DepartmentWiseCourses;

-- Query to find courses whose duration is between 2 and 4
SELECT CourseName, Duration
FROM Course
WHERE Duration BETWEEN 2 AND 4;  -- Filters courses with duration between 2 and 4

-- Query to find students enrolled in courses 101, 102, or 103
SELECT s.StudentName, s.Student
FROM Student s
JOIN Enrollment e ON s.Student = e.Student
WHERE e.Course IN (101, 102, 103);  -- Filters students enrolled in courses 101, 102, or 103

-- Query to find students, course names, instructor names, and department names for a specific instructor ('Tony Stark')
SELECT 
    s.StudentName,  -- Retrieves the student's name
    c.CourseName,   -- Retrieves the course name
    i.InstructorName,  -- Retrieves the instructor's name
    d.DepartmentName   -- Retrieves the department name
FROM 
    Student s
JOIN 
    Enrollment e ON s.Student = e.Student
JOIN 
    Course c ON e.Course = c.Course
JOIN 
    Instructor i ON c.DepartmentName = i.DepartmentName
JOIN 
    Department d ON c.DepartmentName = d.DepartmentName
WHERE 
    i.InstructorName = 'Tony Stark';  -- Filters by the instructor name 'Tony Stark'

-- Query to find departments that do not have any instructor assigned
SELECT 
    d.DepartmentName
FROM 
    Department d
LEFT JOIN 
    Instructor i ON d.DepartmentName = i.DepartmentName
WHERE 
    i.InstructorName IS NULL;  -- Filters departments where no instructor is assigned
