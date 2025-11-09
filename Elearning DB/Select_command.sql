﻿
-- Joins between tables to retrieve related data --

SELECT s.sub_course_id, s.title AS sub_course_title, m.title AS master_course_title
FROM sub_courses s
JOIN master_courses m ON s.master_course_id = m.master_course_id;

SELECT t.topic_id, t.title AS topic_title, sc.title AS sub_course_title
FROM topics t
JOIN sub_courses sc ON t.sub_course_id = sc.sub_course_id;

SELECT m.material_id, m.title AS material_title, t.title AS topic_title, sc.title AS sub_course_title
FROM materials m
JOIN topics t ON m.topic_id = t.topic_id
JOIN sub_courses sc ON t.sub_course_id = sc.sub_course_id;
 

 -- Select Command Examples --
SELECT * FROM users;
SELECT * FROM master_courses;
SELECT * FROM sub_courses;
SELECT * FROM topics;
SELECT * FROM materials;
SELECT * FROM subscriptions;
SELECT * FROM subscription_courses;
SELECT * FROM user_course_enrollments;
SELECT * FROM user_subscriptions;
SELECT * FROM transactions;



