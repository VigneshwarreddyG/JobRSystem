-- Managing Database
CREATE DATABASE job_recruitment_system;
USE job_recruitment_system;

-- User Table
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Employer', 'Applicant') NOT NULL
);

-- Employer Table
CREATE TABLE Employer (
    employer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    company_name VARCHAR(100),
    location VARCHAR(100),
    industry VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Applicant Table
CREATE TABLE Applicant (
    applicant_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    resume BLOB,               -- Stores the uploaded PDF file for the resume
    skills VARCHAR(255),        -- Comma-separated list of skills
    experience TEXT,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Job Posting Table
CREATE TABLE Job_Posting (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT NOT NULL,
    title VARCHAR(100),
    description TEXT,
    location VARCHAR(100),
    salary_min DECIMAL(10, 2),
    salary_max DECIMAL(10, 2),
    posted_date DATE,
    status ENUM('Open', 'Closed') DEFAULT 'Open',
    FOREIGN KEY (employer_id) REFERENCES Employer(employer_id) ON DELETE CASCADE
);

-- Application Table
CREATE TABLE Application (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    applicant_id INT NOT NULL,
    application_date DATE,
    status ENUM('Submitted', 'Reviewed', 'Pending', 'Accepted', 'Rejected') DEFAULT 'Submitted',
    cover_letter BLOB,          -- Stores the uploaded PDF file for the cover letter
    FOREIGN KEY (job_id) REFERENCES Job_Posting(job_id) ON DELETE CASCADE,
    FOREIGN KEY (applicant_id) REFERENCES Applicant(applicant_id) ON DELETE CASCADE
);

-- Skills Table
CREATE TABLE Skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(50) NOT NULL
);
-- Inserting 10 CS industry example skills into the Skills table 
INSERT INTO Skills (skill_name) VALUES 
('Python'),
('Java'),
('C++'),
('JavaScript'),
('SQL'),
('Machine Learning'),
('Data Science'),
('Artificial Intelligence'),
('Cloud Computing'),
('Git');

-- Manage Tables
INSERT INTO Employer (user_id, company_name, location, industry)
VALUES (1, 'TechCorp', 'New York', 'Technology');
INSERT INTO User (username, email, password, role)
VALUES ('employer1', 'employer1@example.com', 'password123', 'Employer');

-- ======== Functionality 1: View All Posted Jobs ========
SELECT job_id, title, description, location, salary_min, salary_max, posted_date, status
FROM Job_Posting;

-- ======== Functionality 2: Post a New Job ========
INSERT INTO Job_Posting (employer_id, title, description, location, salary_min, salary_max, posted_date, status)
VALUES (1, 'Software Developer', 'Develop and maintain software solutions.', 'New York', 60000, 90000, CURDATE(), 'Open');

-- ======== Functionality 3: View Applications for All Jobs ========
SELECT a.application_id, jp.title AS job_title, ap.applicant_id, ap.skills, a.application_date, a.status
FROM Application a
JOIN Job_Posting jp ON a.job_id = jp.job_id
JOIN Applicant ap ON a.applicant_id = ap.applicant_id;

-- ======== Functionality 4: Update Application Status ========
UPDATE Application
SET status = 'Reviewed'
WHERE application_id = 1; -- Replace `1` with the application ID

-- ======== Functionality 5: Manage All Candidates ========
SELECT ap.applicant_id, ap.skills, ap.experience, u.username, u.email
FROM Applicant ap
JOIN User u ON ap.user_id = u.user_id;

-- ======== Functionality 6: Search All Jobs ========
SELECT job_id, title, description, location, salary_min, salary_max, posted_date, status
FROM Job_Posting
WHERE title LIKE '%Developer%' OR description LIKE '%Software%'; -- Replace keywords for your search

-- ======== Functionality 7: Filter All Jobs ========
SELECT job_id, title, description, location, salary_min, salary_max, posted_date, status
FROM Job_Posting
WHERE location = 'New York' AND salary_min >= 50000 AND salary_max <= 100000;

-- ======== Functionality 8: Apply for a Job ========
INSERT INTO Application (job_id, applicant_id, application_date, status, cover_letter)
VALUES (1, 2, CURDATE(), 'Submitted', NULL); -- Replace `job_id` and `applicant_id` as needed

-- ======== Functionality 9: View All Applications ========
SELECT a.application_id, jp.title AS job_title, ap.applicant_id, a.application_date, a.status
FROM Application a
JOIN Job_Posting jp ON a.job_id = jp.job_id
JOIN Applicant ap ON a.applicant_id = ap.applicant_id;

-- ======== Functionality 10: Update Profile ========
UPDATE Applicant
SET resume = NULL, skills = 'Python, Java, SQL', experience = '3 years of software development experience.'
WHERE applicant_id = 2; -- Replace `applicant_id` as needed