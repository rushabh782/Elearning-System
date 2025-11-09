﻿
-- ✅ Create fresh database
CREATE DATABASE ELearningDB;
GO
USE ELearningDB;
GO

-- ✅ Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    Passwordd VARCHAR(255) NOT NULL,
    role VARCHAR(10) CHECK (role IN ('admin', 'user')) NOT NULL,
    status VARCHAR(10) CHECK (status IN ('active', 'inactive')) DEFAULT 'active',
    profile VARCHAR(100)
);

-- ✅ Master Courses
CREATE TABLE master_courses (
    master_course_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    admin_id INT,
    status VARCHAR(10) CHECK (status IN ('active','archived')) DEFAULT 'active',
	price DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (admin_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ✅ Sub Courses
CREATE TABLE sub_courses (
    sub_course_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    master_course_id INT,
    status VARCHAR(10) CHECK (status IN ('active','archived')) DEFAULT 'active',
	price DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (master_course_id) REFERENCES master_courses(master_course_id) ON DELETE CASCADE
);

-- ✅ Topics
CREATE TABLE topics (
    topic_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    sub_course_id INT,
    sequence_number INT,
    FOREIGN KEY (sub_course_id) REFERENCES sub_courses(sub_course_id) ON DELETE CASCADE
);

-- ✅ Materials
CREATE TABLE materials (
    material_id INT PRIMARY KEY IDENTITY,
    topic_id INT,
    title VARCHAR(255),
    type VARCHAR(10) CHECK (type IN ('video','pdf','quiz','link')),
    url VARCHAR(500),
    uploaded_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE CASCADE
);

-- ✅ Subscriptions
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255),	 
    description TEXT,
    price DECIMAL(10,2),
    duration_days INT DEFAULT 30,
	subscription_type VARCHAR(20) NOT NULL DEFAULT 'Gold',
	image_url VARCHAR(500)
);

-- ✅ Subscription Courses
CREATE TABLE subscription_courses (
    id INT PRIMARY KEY IDENTITY,
    subscription_id INT,
    sub_course_id INT,
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id) ON DELETE CASCADE,
    FOREIGN KEY (sub_course_id) REFERENCES sub_courses(sub_course_id) ON DELETE NO ACTION
);

-- ✅ User Course Enrollments
CREATE TABLE user_course_enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    sub_course_id INT,
    enrolled_on DATETIME DEFAULT GETDATE(),
    valid_until DATETIME,
    progress DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (sub_course_id) REFERENCES sub_courses(sub_course_id) ON DELETE NO ACTION
);

-- ✅ User Subscriptions
CREATE TABLE user_subscriptions (
    user_subscription_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    subscription_id INT,
    subscribed_on DATETIME DEFAULT GETDATE(),
    valid_until DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id) ON DELETE CASCADE
);

-- ✅ Transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    sub_course_id INT NULL,
    subscription_id INT NULL,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    status VARCHAR(10) CHECK (status IN ('success','failed','pending')),
    transaction_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (sub_course_id) REFERENCES sub_courses(sub_course_id) ON DELETE NO ACTION,
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id) ON DELETE NO ACTION
);