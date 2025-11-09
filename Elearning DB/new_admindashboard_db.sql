-- Add inactive users for User Status Distribution
USE ELearningDB;
GO

INSERT INTO users (name, email, Passwordd, role, status, profile)
VALUES 
('John Inactive', 'john.inactive@test.com', 'pass1234', 'user', 'inactive', NULL),
('Sarah Dormant', 'sarah.dormant@test.com', 'pass123', 'user', 'inactive', NULL),
('Mike Suspended', 'mike.suspended@test.com', 'pass12345', 'user', 'inactive', NULL),
('Lisa Archived', 'lisa.archived@test.com', 'pass1236', 'user', 'inactive', NULL);

-- Archive some master courses
UPDATE master_courses 
SET status = 'archived' 
WHERE master_course_id IN (
    SELECT TOP 2 master_course_id FROM master_courses WHERE status = 'active'
);

-- Archive some sub courses
UPDATE sub_courses 
SET status = 'archived' 
WHERE sub_course_id IN (
    SELECT TOP 3 sub_course_id FROM sub_courses WHERE status = 'active'
);

-- Add more enrollment data with varied progress
INSERT INTO user_course_enrollments (user_id, sub_course_id, enrolled_on, valid_until, progress)
VALUES 
(1, 3, DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, 15, GETDATE()), 75.50),
(1, 5, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, 10, GETDATE()), 30.25),
(1, 2, DATEADD(DAY, -25, GETDATE()), DATEADD(DAY, 5, GETDATE()), 90.00),
(1, 4, DATEADD(DAY, -30, GETDATE()), DATEADD(DAY, 1, GETDATE()), 15.75);


-- Stored Procedures
USE ELearningDB;
GO

-- User Status Distribution (Active vs Inactive)
CREATE PROCEDURE GetUserStatusDistribution
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) AS active_count,
        SUM(CASE WHEN status = 'inactive' THEN 1 ELSE 0 END) AS inactive_count,
        COUNT(*) AS total_users
    FROM users
    WHERE role = 'user';
END
GO

-- Course Enrollment Stats (Enrolled, Archived, Active)
CREATE PROCEDURE GetCourseEnrollmentStats
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        (SELECT COUNT(DISTINCT sub_course_id) FROM user_course_enrollments WHERE valid_until >= GETDATE()) AS enrolled_courses_count,
        (SELECT COUNT(*) FROM sub_courses WHERE status = 'archived') AS archived_courses_count,
        (SELECT COUNT(*) FROM sub_courses WHERE status = 'active') AS active_courses_count;
END
GO

-- Monthly Enrollment Trends (Last 6 months)
-- CREATE PROCEDURE GetMonthlyEnrollmentTrends
--AS
--BEGIN
--    SET NOCOUNT ON;
    
--    SELECT 
--        FORMAT(enrolled_on, 'MMM yyyy') AS month_year,
--        COUNT(*) AS enrollment_count,
--        SUM(CASE WHEN progress >= 100 THEN 1 ELSE 0 END) AS completion_count
--    FROM user_course_enrollments
--    WHERE enrolled_on >= DATEADD(MONTH, -6, GETDATE())
--    GROUP BY FORMAT(enrolled_on, 'MMM yyyy'), MONTH(enrolled_on), YEAR(enrolled_on)
--    ORDER BY YEAR(enrolled_on), MONTH(enrolled_on);
--END
--GO


EXEC GetUserStatusDistribution

EXEC GetCourseEnrollmentStats

INSERT INTO master_courses (title, description, admin_id, status, price)
VALUES 
-- Technology & Programming
('Mobile App Development', 'Learn to build native and cross-platform mobile applications for iOS and Android', 1, 'active', 1299.00),
('Cloud Computing Fundamentals', 'Master AWS, Azure, and Google Cloud Platform services and architecture', 1, 'active', 1499.00),
('Cybersecurity Essentials', 'Comprehensive guide to network security, ethical hacking, and data protection', 1, 'active', 1799.00);


-- Mobile App Development Sub-Courses (master_course_id = 3, adjust based on your IDs)
INSERT INTO sub_courses (title, description, master_course_id, status, price)
VALUES 
('React Native Fundamentals', 'Build cross-platform apps with React Native', 3, 'active', 499.00),
('Flutter Development', 'Create beautiful native apps with Flutter and Dart', 3, 'active', 549.00),
('iOS Development with Swift', 'Native iOS app development using Swift and SwiftUI', 3, 'active', 599.00),
('Android Development with Kotlin', 'Modern Android apps using Kotlin and Jetpack', 3, 'active', 599.00);

-- Cloud Computing Sub-Courses (master_course_id = 4)
INSERT INTO sub_courses (title, description, master_course_id, status, price)
VALUES 
('AWS Solutions Architect', 'Design and deploy scalable AWS infrastructure', 4, 'active', 699.00),
('Microsoft Azure Administrator', 'Manage Azure resources and cloud services', 4, 'active', 649.00),
('Google Cloud Platform Essentials', 'GCP services, compute, storage, and networking', 4, 'active', 599.00),
('Cloud Security & Compliance', 'Secure cloud environments and meet compliance standards', 4, 'active', 749.00);

-- Cybersecurity Sub-Courses (master_course_id = 5)
INSERT INTO sub_courses (title, description, master_course_id, status, price)
VALUES 
('Ethical Hacking & Penetration Testing', 'Learn to identify and exploit security vulnerabilities', 5, 'active', 899.00),
('Network Security Fundamentals', 'Firewalls, VPNs, IDS/IPS, and secure network design', 5, 'active', 699.00),
('Cryptography & Data Protection', 'Encryption algorithms, PKI, and secure communications', 5, 'active', 749.00),
('Security Operations & Incident Response', 'SOC operations, threat detection, and incident handling', 5, 'active', 799.00);


-- ============================================
-- Updated: GetCourseEnrollmentStats
-- 30-day validity logic ONLY for enrolled_courses_count
-- archived_courses_count and active_courses_count remain unchanged
-- ============================================
USE ELearningDB;
GO



ALTER PROCEDURE GetCourseEnrollmentStats
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        -- Count all enrollments that are currently valid
        (SELECT COUNT(*) 
         FROM user_course_enrollments
         WHERE DATEADD(DAY, 30, enrolled_on) >= GETDATE()
        ) AS enrolled_courses_count,

        -- Count archived sub courses
        (SELECT COUNT(*) 
         FROM sub_courses 
         WHERE status = 'archived'
        ) AS archived_courses_count,

        -- Count active sub courses
        (SELECT COUNT(*) 
         FROM sub_courses 
         WHERE status = 'active'
        ) AS active_courses_count;
END
GO

GO



EXEC GetCourseEnrollmentStats;


--Test Query
SELECT 
    sub_course_id,
    enrolled_on,
    DATEADD(DAY, 30, enrolled_on) AS valid_until,
    CASE 
        WHEN DATEADD(DAY, 30, enrolled_on) >= GETDATE() THEN 'Valid'
        ELSE 'Expired'
    END AS validity_status
FROM user_course_enrollments;

