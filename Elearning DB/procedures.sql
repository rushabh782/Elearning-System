-- =============================================
-- ✅ E-Learning User Stored Procedures
-- ✅ Author: Noumaan
-- ✅ Purpose: Clean, production-ready user logic
-- =============================================

-- 🔥 Delete user by ID (cascade-safe)  1
GO
use ELearningDB;

GO
CREATE PROCEDURE DeleteUserByID
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM users WHERE user_id = @UserId;
END
GO

-- 🔥 Insert new user (signup logic) 2
GO
CREATE PROCEDURE InsertUser
    @name VARCHAR(100),
    @email VARCHAR(100),
    @Passwordd VARCHAR(255),
    @role VARCHAR(10),
    @profile VARCHAR(100)
AS
BEGIN
    INSERT INTO users (name, email, Passwordd, role, profile)
    VALUES (@name, @email, @Passwordd, @role, @profile);
END
GO

-- 🔍 Check if user exists by email (signup validation)  3
GO
CREATE PROCEDURE UserExistProc
    @email VARCHAR(100)
AS
BEGIN
    SELECT * FROM users WHERE email = @email;
END
GO

-- 🔍 Fetch full user profile by email (for display)  4
GO
CREATE PROCEDURE FindProfileByID
    @email_id VARCHAR(100)
AS
BEGIN
    SELECT user_id, name, email, role, profile
    FROM users
    WHERE email = @email_id;
END
GO

-- 🔍 Fetch user by email (for backend logic) 5
GO
CREATE PROCEDURE FindUserByEmail
    @email VARCHAR(100)
AS
BEGIN
    SELECT user_id, name, email, role, status
    FROM users
    WHERE email = @email;
END
GO

-- 🔐 Login procedure (active users only) 6
GO
CREATE PROCEDURE UserLoginProc
    @email VARCHAR(100),
    @pass VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT user_id, name, email, role, status
    FROM users
    WHERE email = @email AND Passwordd = @pass AND status = 'active';
END
GO


GO
-- ✅ Get user dashboard statistics (reverted to working structure with updated AllCourses) 7
CREATE PROCEDURE GetUserDashboardStats
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Enrolled courses count (sub courses only, as per schema)
    SELECT COUNT(*) AS EnrolledCount
    FROM user_course_enrollments
    WHERE user_id = @UserId AND valid_until >= GETDATE();
    
    -- Active subscriptions count
    SELECT COUNT(*) AS SubscriptionCount
    FROM user_subscriptions
    WHERE user_id = @UserId AND valid_until >= GETDATE();
    
    -- All available courses count (active master + sub courses)
    SELECT 
        (SELECT COUNT(*) FROM master_courses WHERE status = 'active') + 
        (SELECT COUNT(*) FROM sub_courses WHERE status = 'active') 
    AS AllCourses;
END
GO


-- ✅ Get all master courses with admin details (including price, handling NULL) 8
GO
CREATE PROCEDURE GetAllMasterCourses
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        mc.master_course_id,
        mc.title,
        mc.description,
        mc.status,
        ISNULL(mc.price, 0) AS price,  -- Ensures price is never NULL
        ISNULL(u.name, 'Admin') AS admin_name
    FROM master_courses mc
    LEFT JOIN users u ON mc.admin_id = u.user_id
    WHERE mc.status IN ('active', 'archived')
    ORDER BY 
        CASE WHEN mc.status = 'active' THEN 0 ELSE 1 END,
        mc.master_course_id DESC;
END
GO

-- ✅ Get all sub courses with master course details (including price, handling NULL) 9
GO
CREATE PROCEDURE GetAllSubCourses
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sc.sub_course_id,
        sc.title,
        sc.description,
        sc.status,
        ISNULL(sc.price, 0) AS price,  -- Ensures price is never NULL
        ISNULL(mc.title, 'No Master Course') AS master_title
    FROM sub_courses sc
    LEFT JOIN master_courses mc ON sc.master_course_id = mc.master_course_id
    WHERE sc.status IN ('active', 'archived')
    ORDER BY 
        CASE WHEN sc.status = 'active' THEN 0 ELSE 1 END,
        sc.sub_course_id DESC;
END
GO

-- ✅ Check if user is already enrolled in a course. 10
GO
CREATE PROCEDURE CheckUserEnrollment
    @UserId INT,
    @SubCourseId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT COUNT(*) AS EnrollmentCount
    FROM user_course_enrollments
    WHERE user_id = @UserId 
    AND sub_course_id = @SubCourseId 
    AND valid_until >= GETDATE();
END
GO

-- ✅ Get active master courses only (including price, handling NULL) 11
GO
CREATE PROCEDURE GetActiveMasterCourses
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        mc.master_course_id,
        mc.title,
        mc.description,
        mc.status,
        ISNULL(mc.price, 0) AS price,  -- Ensures price is never NULL
        ISNULL(u.name, 'Admin') AS admin_name
    FROM master_courses mc
    LEFT JOIN users u ON mc.admin_id = u.user_id
    WHERE mc.status = 'active'
    ORDER BY mc.master_course_id DESC;
END
GO

-- ✅ Get active sub courses only (including price, handling NULL)  12
GO
CREATE PROCEDURE GetActiveSubCourses
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sc.sub_course_id,
        sc.title,
        sc.description,
        sc.status,
        ISNULL(sc.price, 0) AS price,  -- Ensures price is never NULL
        ISNULL(mc.title, 'No Master Course') AS master_title
    FROM sub_courses sc
    LEFT JOIN master_courses mc ON sc.master_course_id = mc.master_course_id
    WHERE sc.status = 'active'
    ORDER BY sc.sub_course_id DESC;
END
GO

-- ✅ Get sub courses by master course ID (including price, handling NULL)  13
GO
CREATE PROCEDURE GetSubCoursesByMasterId
    @MasterCourseId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sc.sub_course_id,
        sc.title,
        sc.description,
        sc.status,
        ISNULL(sc.price, 0) AS price,  -- Ensures price is never NULL
        mc.title AS master_title
    FROM sub_courses sc
    INNER JOIN master_courses mc ON sc.master_course_id = mc.master_course_id
    WHERE mc.master_course_id = @MasterCourseId
    AND sc.status = 'active'
    ORDER BY sc.sub_course_id DESC;
END
GO

-- ✅ AddSubscription (✨ New procedure)  14
GO
CREATE PROCEDURE AddSubscription
    @Title NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @Price DECIMAL(10,2),
    @Duration INT,
    @Type NVARCHAR(50),
    @ImageUrl NVARCHAR(500),
    @SubscriptionId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO subscriptions (title, description, price, duration_days, subscription_type, image_url)
    VALUES (@Title, @Description, @Price, @Duration, @Type, @ImageUrl);

    SET @SubscriptionId = SCOPE_IDENTITY();
END
GO


--AddSubscriptionCourse (✨ New helper proc)  15
GO
CREATE PROCEDURE AddSubscriptionCourse
    @SubscriptionId INT,
    @SubCourseId INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO subscription_courses (subscription_id, sub_course_id)
    VALUES (@SubscriptionId, @SubCourseId);
END
GO

-- Proc Subcription UserDashBoard  16
GO
CREATE PROCEDURE GetAllSubscriptions
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.subscription_id,
        s.title AS subscription_title,
        s.price,
        s.duration_days,
        s.subscription_type,
        s.image_url,
        COUNT(sc.sub_course_id) AS course_count,
        CASE WHEN us.user_subscription_id IS NOT NULL THEN 1 ELSE 0 END AS isSubscribed
    FROM subscriptions s
    LEFT JOIN subscription_courses sc ON s.subscription_id = sc.subscription_id
    LEFT JOIN user_subscriptions us ON s.subscription_id = us.subscription_id AND us.user_id = @UserId
    GROUP BY s.subscription_id, s.title, s.price, s.duration_days, s.subscription_type, s.image_url, us.user_subscription_id
END
GO

-- GetSubscriptionDetails  17
GO

CREATE PROCEDURE GetSubscriptionDetails
    @SubscriptionId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if subscription exists
    IF NOT EXISTS (SELECT 1 FROM subscriptions WHERE subscription_id = @SubscriptionId)
    BEGIN
        SELECT 'Subscription not found.' AS title;
        RETURN;
    END
    
    -- Fetch courses
    SELECT sc.title
    FROM subscription_courses ssc
    INNER JOIN sub_courses sc ON ssc.sub_course_id = sc.sub_course_id
    WHERE ssc.subscription_id = @SubscriptionId
    ORDER BY sc.title;
    
    -- If no courses, return a message
    IF @@ROWCOUNT = 0
    BEGIN
        SELECT 'No courses included yet.' AS title;
    END
END
GO



-- ✅ Get user enrolled courses (for MyCourses page) 18
GO
CREATE PROCEDURE GetUserEnrolledCourses
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Fetch master courses with aggregated data from enrolled sub-courses
    SELECT 
        'master' AS course_type,
        mc.master_course_id AS course_id,
        mc.title,
        CAST(mc.description AS NVARCHAR(MAX)) AS description,
        MIN(uce.enrolled_on) AS enrolled_on,  -- Earliest enrollment date
        MAX(uce.valid_until) AS valid_until,  -- Latest valid date
        AVG(uce.progress) AS progress,  -- Average progress of enrolled sub-courses
        COUNT(DISTINCT sc.sub_course_id) AS sub_course_count
    FROM master_courses mc
    INNER JOIN sub_courses sc ON mc.master_course_id = sc.master_course_id
    INNER JOIN user_course_enrollments uce ON sc.sub_course_id = uce.sub_course_id AND uce.user_id = @UserId
    GROUP BY mc.master_course_id, mc.title, CAST(mc.description AS NVARCHAR(MAX))
    
    UNION ALL
    
    -- Fetch enrolled sub-courses
    SELECT 
        'sub' AS course_type,
        sc.sub_course_id AS course_id,
        sc.title,
        CAST(sc.description AS NVARCHAR(MAX)) AS description,
        uce.enrolled_on,
        uce.valid_until,
        uce.progress,
        NULL AS sub_course_count
    FROM user_course_enrollments uce
    INNER JOIN sub_courses sc ON uce.sub_course_id = sc.sub_course_id
    WHERE uce.user_id = @UserId
    
    ORDER BY course_type DESC, course_id;
END
GO

SELECT name FROM sys.procedures ORDER BY name desc;
