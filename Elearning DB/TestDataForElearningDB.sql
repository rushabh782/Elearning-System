-- =============================================
-- Efficient Test Data for E-Learning Dashboard
-- Optimized to populate all stored procedures with meaningful data
-- =============================================

USE ELearningDB;
GO

-- =============================================
-- 1. USERS - Mix of active/inactive for charts
-- =============================================
INSERT INTO users (name, email, Passwordd, role, status, profile)
VALUES 

-- Active Users (for User Status Chart)
('Alice Johnson', 'alice@test.com', 'pass123', 'user', 'active', NULL),
('Bob Smith', 'bob@test.com', 'pass123', 'user', 'active', NULL),
('Carol White', 'carol@test.com', 'pass123', 'user', 'active', NULL),
('David Brown', 'david@test.com', 'pass123', 'user', 'active', NULL),
('Emma Davis', 'emma@test.com', 'pass123', 'user', 'active', NULL),

-- Inactive Users (for User Status Chart & Dormant Users Report)
('Frank Miller', 'frank@test.com', 'pass123', 'user', 'inactive', NULL),
('Grace Wilson', 'grace@test.com', 'pass123', 'user', 'inactive', NULL),
('Henry Moore', 'henry@test.com', 'pass123', 'user', 'inactive', NULL);

GO

-- =============================================
-- 2. MASTER COURSES - 4 courses (2 active, 2 archived)
-- =============================================
INSERT INTO master_courses (title, description, admin_id, status, price)
VALUES 
-- Active Courses
('Web Development Bootcamp', 'Complete full-stack web development course', 1, 'active', 2999.00),
('Data Science Fundamentals', 'Python, ML, and data analysis essentials', 1, 'active', 3499.00),

-- Archived Courses (for Course Enrollment Chart)
('Mobile App Development', 'iOS and Android development basics', 1, 'archived', 2499.00),
('Digital Marketing Pro', 'SEO, SEM, and social media marketing', 1, 'archived', 1999.00);

GO

-- =============================================
-- 3. SUB COURSES - 12 sub-courses with varied status
-- =============================================
INSERT INTO sub_courses (title, description, master_course_id, status, price)
VALUES
-- Master Course 1: Full Stack Web Development
('HTML & CSS Basics', 'Learn the basics of HTML and CSS', 1, 'active', 499.00),
('JavaScript Essentials', 'Introduction to JavaScript programming', 1, 'active', 599.00),
('React Fundamentals', 'Learn React to build dynamic UIs', 1, 'active', 699.00),

-- Master Course 2: Python Programming
('Python Basics', 'Introduction to Python programming', 2, 'active', 499.00),
('Advanced Python', 'OOP, modules, and libraries in Python', 2, 'active', 599.00),
('Python Projects', 'Hands-on Python projects', 2, 'active', 699.00),

-- Master Course 3: Mobile App Development
('React Native Basics', 'Learn cross-platform mobile development', 3, 'active', 699.00),
('Android Development', 'Build native Android apps', 3, 'active', 799.00),
('iOS Development', 'Build native iOS apps', 3, 'active', 799.00),

-- Master Course 4: Cloud Computing Fundamentals
('AWS Basics', 'Introduction to Amazon Web Services', 4, 'active', 799.00),
('Azure Essentials', 'Microsoft Azure fundamentals', 4, 'active', 799.00),
('Cloud Projects', 'Hands-on cloud computing projects', 4, 'active', 899.00),

-- Master Course 5: Cybersecurity Essentials
('Network Security', 'Learn network security fundamentals', 5, 'active', 899.00),
('Ethical Hacking', 'Basics of ethical hacking', 5, 'active', 999.00),
('Cybersecurity Projects', 'Practical cybersecurity exercises', 5, 'active', 1099.00);

-- Continue the same pattern for master_course_id 6 to 17...
INSERT INTO sub_courses (title, description, master_course_id, status, price)
VALUES
-- Master Course 6: Web Development Bootcamp
('Frontend Basics', 'Learn HTML, CSS, and responsive design', 6, 'active', 699.00),
('Backend with Node.js', 'Server-side development using Node.js', 6, 'active', 899.00),
('Full-Stack Project', 'Build a full-stack web application', 6, 'active', 999.00),

-- Master Course 7: Data Science Fundamentals
('Data Analysis with Python', 'NumPy and Pandas for data analysis', 7, 'active', 799.00),
('Statistics for Data Science', 'Learn core statistics and probability', 7, 'active', 899.00),
('Intro to Machine Learning', 'Basic ML models using Scikit-learn', 7, 'active', 999.00),

-- Master Course 8: Mobile App Development
('Flutter Basics', 'Cross-platform mobile apps with Flutter', 8, 'active', 899.00),
('Android Studio Essentials', 'Native app development for Android', 8, 'active', 999.00),
('UI/UX for Mobile Apps', 'Design visually stunning mobile apps', 8, 'active', 749.00),

-- Master Course 9: Digital Marketing Pro
('SEO Strategy', 'Search engine optimization skills', 9, 'active', 599.00),
('Social Media Ads', 'Paid marketing on Facebook & Instagram', 9, 'active', 699.00),
('Content Creation Mastery', 'Craft content that converts', 9, 'active', 749.00);

-- =============================================
-- 4. TOPICS - 3 topics per sub-course (36 total, but let's add 18)
-- =============================================
INSERT INTO topics (title, sub_course_id, sequence_number)
VALUES
-- Topics for 'HTML & CSS Basics' (sub_course_id = 54)
('HTML Tags and Structure', 54, 1),
('CSS Styling Basics', 54, 2),
('Responsive Design', 54, 3),

-- Topics for 'JavaScript Essentials' (sub_course_id = 55)
('Variables and Data Types', 55, 1),
('Functions and Scope', 55, 2),
('DOM Manipulation', 55, 3),

-- Topics for 'React Fundamentals' (sub_course_id = 56)
('React Components', 56, 1),
('State and Props', 56, 2),
('Hooks Deep Dive', 56, 3),

-- Topics for 'Python Basics' (sub_course_id = 57)
('Python Syntax and Variables', 57, 1),
('OOP in Python', 57, 2),
('File Handling', 57, 3),

-- Topics for 'Intro to Machine Learning' (sub_course_id = 74)
('Supervised Learning', 74, 1),
('Unsupervised Learning', 74, 2),
('Model Evaluation', 74, 3),

-- Topics for 'Data Analysis with Python' (sub_course_id = 72)
('Matplotlib Basics', 72, 1),
('Seaborn Advanced', 72, 2),
('Interactive Dashboards', 72, 3);
GO

-- =============================================
-- 5. MATERIALS - Mix of video, pdf, quiz, link (48 total)
-- =============================================
INSERT INTO materials (topic_id, title, type, url)
VALUES
-- HTML & CSS Topics (IDs: 81, 82, 83)
(81, 'HTML Introduction', 'video', 'https://example.com/html-intro.mp4'),
(81, 'HTML Tags Reference', 'pdf', 'https://example.com/html-tags.pdf'),
(82, 'CSS Selectors Quiz', 'quiz', 'https://example.com/css-quiz'),
(82, 'Flexbox Guide', 'video', 'https://example.com/flexbox.mp4'),
(83, 'Responsive Design Patterns', 'link', 'https://example.com/responsive'),
(83, 'CSS Grid Tutorial', 'video', 'https://example.com/grid.mp4'),

-- JavaScript Topics (IDs: 84, 85, 86)
(84, 'JS Variables Explained', 'video', 'https://example.com/js-vars.mp4'),
(84, 'Data Types Guide', 'pdf', 'https://example.com/datatypes.pdf'),
(85, 'Functions Masterclass', 'video', 'https://example.com/functions.mp4'),
(85, 'Scope Quiz', 'quiz', 'https://example.com/scope-quiz'),
(86, 'DOM API Reference', 'link', 'https://example.com/dom-api'),
(86, 'Event Handling', 'video', 'https://example.com/events.mp4'),

-- React Topics (IDs: 87, 88, 89)
(87, 'Components Basics', 'video', 'https://example.com/components.mp4'),
(87, 'React Documentation', 'link', 'https://reactjs.org'),
(88, 'State Management', 'video', 'https://example.com/state.mp4'),
(88, 'Props Quiz', 'quiz', 'https://example.com/props-quiz'),
(89, 'Hooks Tutorial', 'video', 'https://example.com/hooks.mp4'),
(89, 'Custom Hooks', 'pdf', 'https://example.com/custom-hooks.pdf'),

-- Python Topics (IDs: 90, 91, 92)
(90, 'Python Intro', 'video', 'https://example.com/python-intro.mp4'),
(90, 'Python Cheat Sheet', 'pdf', 'https://example.com/python-cheat.pdf'),
(91, 'OOP Concepts', 'video', 'https://example.com/oop.mp4'),
(91, 'Classes Quiz', 'quiz', 'https://example.com/classes-quiz'),
(92, 'File I/O Operations', 'video', 'https://example.com/file-io.mp4'),
(92, 'Working with CSV', 'pdf', 'https://example.com/csv.pdf'),

-- ML Topics (IDs: 93, 94, 95)
(93, 'Linear Regression', 'video', 'https://example.com/linear-reg.mp4'),
(93, 'Classification Algorithms', 'pdf', 'https://example.com/classification.pdf'),
(94, 'K-Means Clustering', 'video', 'https://example.com/kmeans.mp4'),
(94, 'Clustering Quiz', 'quiz', 'https://example.com/clustering-quiz'),
(95, 'Model Metrics', 'video', 'https://example.com/metrics.mp4'),
(95, 'Cross Validation', 'link', 'https://example.com/cross-val'),

-- Data Viz Topics (IDs: 96, 97, 98)
(96, 'Matplotlib Basics', 'video', 'https://example.com/matplotlib.mp4'),
(96, 'Plot Types Guide', 'pdf', 'https://example.com/plot-types.pdf'),
(97, 'Seaborn Tutorial', 'video', 'https://example.com/seaborn.mp4'),
(97, 'Styling Charts', 'quiz', 'https://example.com/styling-quiz'),
(98, 'Plotly Interactive', 'video', 'https://example.com/plotly.mp4'),
(98, 'Dashboard with Dash', 'link', 'https://example.com/dash');
GO

-- =============================================
-- 6. SUBSCRIPTIONS - 2 subscription packages
-- =============================================
INSERT INTO subscriptions (title, description, price, duration_days, subscription_type, image_url)
VALUES
('Gold Package', 'Access to all web development courses', 4999.00, 30, 'Gold', 'https://example.com/gold.jpg'),
('Platinum Package', 'Unlimited access to all courses', 9999.00, 30, 'Platinum', 'https://example.com/platinum.jpg'),
('Silver Package', 'Access to all fundamental & beginner courses', 2999.00, 30, 'Silver', 'https://example.com/silver.jpg');
GO


-- =============================================
-- 7. SUBSCRIPTION COURSES - Link courses to subscriptions
-- =============================================
INSERT INTO subscription_courses (subscription_id, sub_course_id)
VALUES
-- Gold Package (subscription_id = 13) - All Web Dev Courses (from master_id 1 & 6)
(13, 54), -- HTML & CSS Basics
(13, 55), -- JavaScript Essentials
(13, 56), -- React Fundamentals
(13, 69), -- Frontend Basics
(13, 70), -- Backend with Node.js
(13, 71), -- Full-Stack Project

-- Platinum Package (subscription_id = 14) - All Courses
(14, 54), (14, 55), (14, 56), (14, 57), (14, 58), (14, 59),
(14, 60), (14, 61), (14, 62), (14, 63), (14, 64), (14, 65),
(14, 66), (14, 67), (14, 68), (14, 69), (14, 70), (14, 71),
(14, 72), (14, 73), (14, 74), (14, 75), (14, 76), (14, 77),
(14, 78), (14, 79), (14, 80),

-- Silver Package (subscription_id = 15) - All Fundamental/Basics Courses
(15, 54), -- HTML & CSS Basics
(15, 55), -- JavaScript Essentials
(15, 57), -- Python Basics
(15, 60), -- React Native Basics
(15, 63), -- AWS Basics
(15, 64), -- Azure Essentials
(15, 66), -- Network Security
(15, 67), -- Ethical Hacking
(15, 69), -- Frontend Basics
(15, 72), -- Data Analysis with Python
(15, 74), -- Intro to Machine Learning
(15, 75), -- Flutter Basics
(15, 76), -- Android Studio Essentials
(15, 77), -- UI/UX for Mobile Apps
(15, 78); -- SEO Strategy
GO




-- =============================================
-- 8. USER ENROLLMENTS - Varied dates for MoM Growth & Engagement Reports
-- =============================================
INSERT INTO user_course_enrollments (user_id, sub_course_id, enrolled_on, valid_until, progress)
VALUES
-- Alice Johnson (user_id = 10) - Active learner
(10, 54, DATEADD(MONTH, -5, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -5, GETDATE())), 95.00), -- HTML & CSS
(10, 55, DATEADD(MONTH, -4, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -4, GETDATE())), 78.50), -- JavaScript

-- Bob Smith (user_id = 11) - Medium engagement
(11, 57, DATEADD(MONTH, -4, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -4, GETDATE())), 60.00), -- Python Basics
(11, 58, DATEADD(MONTH, -2, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -2, GETDATE())), 30.00), -- Advanced Python

-- Carol White (user_id = 12) - Recent enrollments
(12, 54, DATEADD(MONTH, -1, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -1, GETDATE())), 25.00), -- HTML & CSS
(12, 59, DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, 30, DATEADD(DAY, -15, GETDATE())), 15.00), -- Python Projects

-- David Brown (user_id = 13) - Completed one course
(13, 55, DATEADD(MONTH, -6, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -6, GETDATE())), 100.00), -- JavaScript
(13, 60, DATEADD(MONTH, -3, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -3, GETDATE())), 50.00); -- React Native Basics
GO

PRINT 'User enrollments inserted successfully with correct IDs and 30-day validity!';

INSERT INTO user_course_enrollments (user_id, sub_course_id, enrolled_on, valid_until, progress)
VALUES
-- Emma (user_id = 14) enrolls in Android Dev (sub_course_id = 61)
-- Enrolled 5 days ago, valid for 30 days total
(14, 61, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, 30, DATEADD(DAY, -5, GETDATE())), 89.00),

-- Frank (user_id = 15) enrolls in AWS Basics (sub_course_id = 63)
-- Enrolled today, valid for 30 days
(15, 63, GETDATE(), DATEADD(DAY, 30, GETDATE()), 10.00),

-- Grace (user_id = 16) enrolls in Network Security (sub_course_id = 66)
-- Enrolled 10 days ago, valid for 30 days total
(16, 66, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, 30, DATEADD(DAY, -10, GETDATE())), 60.00),

-- Henry (user_id = 17) enrolls in Data Analysis (sub_course_id = 72)
-- Enrolled 2 days ago, valid for 30 days total
(17, 72, DATEADD(DAY, -2, GETDATE()), DATEADD(DAY, 30, DATEADD(DAY, -2, GETDATE())), 15.00),

-- Alice (user_id = 10) also enrolls in SEO Strategy (sub_course_id = 78)
-- Enrolled today, valid for 30 days
(10, 78, GETDATE(), DATEADD(DAY, 30, GETDATE()), 10.00);
GO

PRINT 'Added 5 new active enrollments, all with 30-day validity!';


-- =============================================
-- 9. USER SUBSCRIPTIONS - Active subscriptions
-- =============================================
INSERT INTO user_subscriptions (user_id, subscription_id, subscribed_on, valid_until)
VALUES
-- Alice (user_id = 10) subscribes to Gold (sub_id = 13)
(10, 13, DATEADD(MONTH, -2, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -2, GETDATE()))),

-- Carol (user_id = 12) subscribes to Platinum (sub_id = 14)
(12, 14, DATEADD(MONTH, -1, GETDATE()), DATEADD(DAY, 30, DATEADD(MONTH, -1, GETDATE()))),

-- Emma (user_id = 14) subscribes to Silver (sub_id = 15)
(14, 15, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, 30, DATEADD(DAY, -10, GETDATE())));
GO

PRINT 'User subscriptions inserted successfully with correct IDs and 30-day validity!';

-- =============================================
-- 10. TRANSACTIONS - Mix of payment methods and statuses
-- =============================================
INSERT INTO transactions (user_id, sub_course_id, subscription_id, amount, payment_method, status, transaction_date)
VALUES
-- User 10 (Alice Johnson)
(10, 54, NULL, 499.00, 'UPI', 'success', DATEADD(MONTH, -5, GETDATE())),       -- Buys HTML & CSS
(10, 55, NULL, 599.00, 'card', 'success', DATEADD(MONTH, -4, GETDATE())),      -- Buys JavaScript
(10, NULL, 13, 4999.00, 'UPI', 'success', DATEADD(MONTH, -2, GETDATE())),      -- Buys Gold Package

-- User 12 (Carol White)
(12, 54, NULL, 499.00, 'wallet', 'success', DATEADD(MONTH, -1, GETDATE())),   -- Buys HTML & CSS
(12, 59, NULL, 799.00, 'card', 'success', DATEADD(DAY, -15, GETDATE())),      -- Buys Python Projects
(12, NULL, 14, 9999.00, 'card', 'success', DATEADD(MONTH, -1, GETDATE())),     -- Buys Platinum Package

-- User 13 (David Brown)
(13, 55, NULL, 599.00, 'wallet', 'success', DATEADD(MONTH, -6, GETDATE())),   -- Buys JavaScript
(13, 60, NULL, 699.00, 'UPI', 'success', DATEADD(MONTH, -3, GETDATE())),      -- Buys React Native Basics
(13, 57, NULL, 499.00, 'card', 'failed', DATEADD(DAY, -20, GETDATE())),       -- Failed to buy Python Basics

-- User 14 (Emma Davis)
(14, NULL, 15, 2999.00, 'card', 'success', DATEADD(DAY, -10, GETDATE())),     -- Buys Silver Package
(14, 72, NULL, 799.00, 'UPI', 'pending', DATEADD(DAY, -2, GETDATE()));        -- Pending Data Analysis




-- =============================================
-- 10. TRANSACTIONS - Adding a pending subscription
-- =============================================
INSERT INTO transactions (user_id, sub_course_id, subscription_id, amount, payment_method, status, transaction_date)
VALUES
-- **NEW DATA ADDED BELOW**
-- User 15 (Frank Miller) - Pending Gold Package
(15, NULL, 13, 4999.00, 'wallet', 'pending', DATEADD(DAY, -1, GETDATE()));    -- Pending Gold Package
GO

PRINT 'Transactions inserted, including new pending subscription!';


SELECT user_id, name 
FROM users 
ORDER BY user_id;


-- =============================================
-- VERIFICATION QUERIES
-- =============================================
PRINT '=== DATA INSERTION COMPLETE ===';
PRINT '';
PRINT 'Quick Stats:';
SELECT 'Users' AS Category, COUNT(*) AS Count FROM users
UNION ALL SELECT 'Master Courses', COUNT(*) FROM master_courses
UNION ALL SELECT 'Sub Courses', COUNT(*) FROM sub_courses
UNION ALL SELECT 'Topics', COUNT(*) FROM topics
UNION ALL SELECT 'Materials', COUNT(*) FROM materials
UNION ALL SELECT 'Subscriptions', COUNT(*) FROM subscriptions
UNION ALL SELECT 'Enrollments', COUNT(*) FROM user_course_enrollments
UNION ALL SELECT 'Transactions', COUNT(*) FROM transactions;

PRINT '';
PRINT '=== TESTING STORED PROCEDURES ===';

-- Test each procedure
PRINT 'Testing GetUserStatusDistribution...';
EXEC GetUserStatusDistribution;

PRINT 'Testing GetCourseEnrollmentStats...';
EXEC GetCourseEnrollmentStats;

PRINT 'Testing GetSubCourseCompletionRates...';
EXEC GetSubCourseCompletionRates;

PRINT 'Testing GetCourseEnrollmentVsRevenue...';
EXEC GetCourseEnrollmentVsRevenue;

PRINT 'Testing GetUserEngagementMetrics...';
EXEC GetUserEngagementMetrics @InactiveDays = 30;

PRINT 'Testing GetTransactionBreakdown...';
EXEC GetTransactionBreakdown;

PRINT 'Testing GetContentDistribution...';
EXEC GetContentDistribution;

PRINT 'Testing GetDormantUsers...';
EXEC GetDormantUsers @DormantDays = 30;

PRINT 'Testing GetMonthlyUserRegistrations...';
EXEC GetMonthlyUserRegistrations;

PRINT '';
PRINT '=== ALL TESTS COMPLETE ===';
PRINT 'Your dashboard should now have meaningful data in all charts and reports!';

-- Run this to verify all procedures were created
   SELECT name FROM sys.procedures WHERE name LIKE 'Get%' ORDER BY name;