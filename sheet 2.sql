-- Create a new database named Library
CREATE DATABASE Library;

-- Use the newly created Library database
USE Library;

-- Create the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each book
    Title VARCHAR(255) NOT NULL,  -- Title of the book, cannot be null
    Author VARCHAR(255),  -- Author of the book
    PublishedYear INT,  -- Year the book was published
    Genre VARCHAR(100),  -- Genre of the book
    AvailableCopies INT  -- Number of copies available
);

-- Insert sample records into Books table
INSERT INTO Books (Title, Author, PublishedYear, Genre, AvailableCopies) VALUES
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', 5),
('1984', 'George Orwell', 1949, 'Dystopian', 8),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic', 4),
('Moby Dick', 'Herman Melville', 1851, 'Adventure', 3),
('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 7);

-- Create the Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each author
    Name VARCHAR(255) NOT NULL,  -- Author's name, cannot be null
    Nationality VARCHAR(100),  -- Nationality of the author
    BirthYear INT,  -- Year of birth of the author
    DeathYear INT  -- Year of death, NULL if still alive
);

-- Insert sample records into Authors table
INSERT INTO Authors (Name, Nationality, BirthYear, DeathYear) VALUES
('Harper Lee', 'American', 1926, 2016),
('George Orwell', 'British', 1903, 1950),
('F. Scott Fitzgerald', 'American', 1896, 1940),
('Herman Melville', 'American', 1819, 1891),
('Jane Austen', 'British', 1775, 1817);

-- Retrieve all books
SELECT * FROM Books;

-- Retrieve books published after 1950, displaying only Title and Author
SELECT Title, Author FROM Books WHERE PublishedYear > 1950;

-- Find the total number of available copies for each genre
SELECT Genre, SUM(AvailableCopies) AS TotalCopies FROM Books GROUP BY Genre;

-- Retrieve books where the number of available copies is greater than 5
SELECT * FROM Books WHERE AvailableCopies > 5;

-- List all books with 'The' in the title (case insensitive search)
SELECT * FROM Books WHERE Title LIKE '%The%';

-- Update available copies of a specific book by adding 2 more
UPDATE Books SET AvailableCopies = AvailableCopies + 2 WHERE Title = '1984';

-- Change the genre of a specific book
UPDATE Books SET Genre = 'Science Fiction' WHERE Title = 'Brave New World';

-- Update the PublishedYear of a book to correct an error
UPDATE Books SET PublishedYear = 1954 WHERE Title = 'The Lord of the Rings';

-- Decrease the available copies for all books published before 2000 by 1
UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE PublishedYear < 2000 AND AvailableCopies > 0;

-- Delete a book based on its title
DELETE FROM Books WHERE Title = '1984';

-- Remove all books with less than 5 available copies
DELETE FROM Books WHERE AvailableCopies < 5;

-- Delete all books from a specific genre
DELETE FROM Books WHERE Genre = 'Science Fiction';

-- Add a new column to track ISBN numbers
ALTER TABLE Books ADD COLUMN ISBN VARCHAR(20) UNIQUE;

-- Insert a new book with all details including ISBN
INSERT INTO Books (Title, Author, PublishedYear, Genre, AvailableCopies, ISBN) 
VALUES ('The Catcher in the Rye', 'J.D. Salinger', 1951, 'Fiction', 10, '9780316769488');

-- Retrieve books sorted by PublishedYear in descending order
SELECT * FROM Books ORDER BY PublishedYear DESC;

-- Retrieve the oldest book in the database
SELECT * FROM Books ORDER BY PublishedYear ASC LIMIT 1;

-- Find the number of books in each genre using GROUP BY
SELECT Genre, COUNT(*) AS NumberOfBooks FROM Books GROUP BY Genre;

-- Find all unique genres using DISTINCT
SELECT DISTINCT Genre FROM Books;

-- Retrieve books published after 2000 that are either in 'Fiction' genre or not written by 'Jane Austen'
SELECT * FROM Books WHERE PublishedYear > 2000 AND (Genre = 'Fiction' OR Author <> 'Jane Austen');

-- Find the average number of available copies across all books
SELECT AVG(AvailableCopies) AS AverageCopies FROM Books;

-- Find the maximum number of available copies for any book
SELECT MAX(AvailableCopies) AS MaxCopies FROM Books;

-- Find all books with titles starting with the letter 'P'
SELECT * FROM Books WHERE Title LIKE 'P%';

-- Retrieve books where the PublishedYear is between 1900 and 2000
SELECT * FROM Books WHERE PublishedYear BETWEEN 1900 AND 2000;

-- Retrieve books with specified genres using the IN operator
SELECT * FROM Books WHERE Genre IN ('Fiction', 'Romance');

-- Perform an INNER JOIN between Books and Authors to get book details along with author details
SELECT Books.Title, Books.PublishedYear, Authors.Name, Authors.Nationality 
FROM Books INNER JOIN Authors ON Books.Author = Authors.Name;

-- Use HAVING clause to filter genres that have more than 5 books
SELECT Genre, COUNT(*) AS NumberOfBooks FROM Books GROUP BY Genre HAVING COUNT(*) > 5;

-- Use EXISTS to check if any books have less than 3 available copies
SELECT EXISTS (SELECT 1 FROM Books WHERE AvailableCopies < 3) AS BookExists;
