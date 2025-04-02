-- Create the database named "School"
CREATE DATABASE School;

-- Select the database to use
USE School;

-- Create the "Students" table with required columns
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each student
    Name VARCHAR(100) NOT NULL,  -- Student's name
    Age INT CHECK (Age > 0),  -- Ensures age is greater than 0
    Grade VARCHAR(10) NOT NULL,  -- Stores grade level (e.g., "10th", "12th")
    EnrollmentDate DATE NOT NULL  -- Stores the enrollment date
);

-- Insert sample student records
INSERT INTO Students (Name, Age, Grade, EnrollmentDate) VALUES
('Aarav Sharma', 14, '9th', '2023-06-12'),
('Ishita Verma', 15, '10th', '2022-07-10'),
('Rahul Mehta', 13, '8th', '2023-05-18'),
('Sanya Kapoor', 12, '7th', '2024-02-01'),
('Kunal Rathore', 16, '11th', '2021-09-15'),
('Neha Chauhan', 17, '12th', '2020-08-20'),
('Rohan Malhotra', 14, '9th', '2023-06-25'),
('Priya Joshi', 13, '8th', '2023-04-14'),
('Aditya Bansal', 15, '10th', '2022-06-30'),
('Simran Kaur', 16, '11th', '2021-07-19'),
('Manav Thakur', 14, '9th', '2023-06-05'),
('Kriti Sharma', 12, '7th', '2024-01-12'),
('Vivek Agarwal', 13, '8th', '2023-03-22'),
('Riya Singh', 17, '12th', '2020-07-17'),
('Dhruv Kapoor', 16, '11th', '2021-10-11'),
('Tanya Sethi', 15, '10th', '2022-05-28'),
('Harsh Tiwari', 14, '9th', '2023-06-15'),
('Ananya Yadav', 12, '7th', '2024-03-07'),
('Yash Dubey', 13, '8th', '2023-04-25'),
('Pooja Gupta', 17, '12th', '2020-09-10');

-- Retrieve all student records
SELECT * FROM Students;

-- Retrieve students older than 15
SELECT * FROM Students WHERE Age > 15;

-- Count the total number of students in each grade
SELECT Grade, COUNT(*) AS TotalStudents 
FROM Students 
GROUP BY Grade;

-- Update the grade of the student with StudentID = 2
UPDATE Students 
SET Grade = '11th' 
WHERE StudentID = 2;

-- Delete students who were enrolled before the year 2020
DELETE FROM Students 
WHERE EnrollmentDate < '2020-01-01';

-- Add a new column "Email" to the Students table
ALTER TABLE Students 
ADD COLUMN Email VARCHAR(100);

-- View all records after adding the "Email" column
SELECT * FROM Students;

-- Disable safe update mode (needed in some databases like MySQL)
SET sql_safe_updates = 0;

-- Update all student email addresses to "abc@gmail.com"
UPDATE Students 
SET Email = 'abc@gmail.com';

-- Update the email and grade of the student with StudentID = 5
UPDATE Students 
SET Email = 'student5@gmail.com', Grade = '12th' 
WHERE StudentID = 5;
