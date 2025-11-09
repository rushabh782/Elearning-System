GO
USE ELearningDB;
GO

-- =============================================
-- 1. GetMonthlyUserRegistrations (for MoM Growth Chart)
-- Returns monthly user registration data for the last 12 months
-- =============================================
CREATE PROCEDURE GetMonthlyUserRegistrations
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        FORMAT(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE())), 'MMM yyyy') AS month_label,
        MONTH(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE()))) AS month_num,
        YEAR(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE()))) AS year_num,
        ISNULL(COUNT(u.user_id), 0) AS registration_count
    FROM 
        (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11) AS months
    LEFT JOIN users u ON 
        MONTH(u.user_id) = MONTH(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE())))
        AND YEAR(u.user_id) = YEAR(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE())))
    GROUP BY 
        DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE())),
        MONTH(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE()))),
        YEAR(DATEADD(MONTH, n, DATEADD(MONTH, -11, GETDATE())))
    ORDER BY year_num, month_num;
END
GO

-- =============================================
-- 2. GetSubCourseCompletionRates (for Course Performance Reports)
-- Returns completion rates for all active sub-courses
-- =============================================
CREATE PROCEDURE GetSubCourseCompletionRates
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        sc.sub_course_id,
        sc.title AS sub_course_title,
        COUNT(uce.enrollment_id) AS TotalEnrollments,
        ISNULL(AVG(uce.progress), 0.00) AS AverageProgress,
        SUM(CASE WHEN uce.progress >= 95.00 THEN 1 ELSE 0 END) AS CompletedCount,
        CAST(ISNULL(SUM(CASE WHEN uce.progress >= 95.00 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(uce.enrollment_id), 0), 0.00) AS DECIMAL(5,2)) AS CompletionRatePercentage
    FROM
        sub_courses sc
    LEFT JOIN
        user_course_enrollments uce ON sc.sub_course_id = uce.sub_course_id
    WHERE
        sc.status = 'active'
    GROUP BY
        sc.sub_course_id, sc.title
    ORDER BY
        CompletionRatePercentage DESC, TotalEnrollments DESC;
END
GO

-- 3. GetCourseEnrollmentVsRevenue (for Most Enrolled vs Highest Revenue Report)
-- Returns enrollment count and revenue for each sub-course
-- =============================================
CREATE PROCEDURE GetCourseEnrollmentVsRevenue
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Default to last 6 months if no dates provided
    IF @StartDate IS NULL
        SET @StartDate = DATEADD(MONTH, -6, GETDATE());
    IF @EndDate IS NULL
        SET @EndDate = GETDATE();

    SELECT
        sc.sub_course_id,
        sc.title AS sub_course_title,
        sc.status,
        COUNT(DISTINCT uce.enrollment_id) AS enrollment_count,
        ISNULL(SUM(t.amount), 0.00) AS total_revenue,
        sc.price AS course_price
    FROM
        sub_courses sc
    LEFT JOIN
        user_course_enrollments uce ON sc.sub_course_id = uce.sub_course_id
        AND uce.enrolled_on BETWEEN @StartDate AND @EndDate
    LEFT JOIN
        transactions t ON sc.sub_course_id = t.sub_course_id
        AND t.status = 'success'
        AND t.transaction_date BETWEEN @StartDate AND @EndDate
    WHERE
        sc.status IN ('active', 'archived')
    GROUP BY
        sc.sub_course_id, sc.title, sc.status, sc.price
    ORDER BY
        enrollment_count DESC, total_revenue DESC;
END
GO

-- 4. GetUserEngagementMetrics (for User Activity Heatmap)
-- Returns user engagement metrics including last login and activity status
-- =============================================
create PROCEDURE GetUserEngagementMetrics
    @InactiveDays INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.user_id,
        u.name,
        u.email,
        u.status,
        COUNT(DISTINCT uce.enrollment_id) AS total_enrollments,
        AVG(uce.progress) AS avg_progress,
        MAX(uce.enrolled_on) AS last_enrollment_date,
        DATEDIFF(DAY, MAX(uce.enrolled_on), GETDATE()) AS days_since_last_activity,
        CASE 
            WHEN DATEDIFF(DAY, MAX(uce.enrolled_on), GETDATE()) > @InactiveDays THEN 'Dormant'
            WHEN DATEDIFF(DAY, MAX(uce.enrolled_on), GETDATE()) > 10 THEN 'At Risk'
            ELSE 'Active'
        END AS engagement_status
    FROM
        users u
    LEFT JOIN
        user_course_enrollments uce ON u.user_id = uce.user_id
    WHERE
        u.role = 'user'
    GROUP BY
        u.user_id, u.name, u.email, u.status
    ORDER BY
        days_since_last_activity DESC;
END
GO

-- 5. GetTransactionBreakdown (for Financial Reports)
-- Returns transaction breakdown by payment method and status
-- =============================================
CREATE PROCEDURE GetTransactionBreakdown
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Default to current year if no dates provided
    IF @StartDate IS NULL
        SET @StartDate = DATEFROMPARTS(YEAR(GETDATE()), 1, 1);
    IF @EndDate IS NULL
        SET @EndDate = GETDATE();

    SELECT
        payment_method,
        status,
        COUNT(*) AS transaction_count,
        SUM(amount) AS total_amount,
        AVG(amount) AS avg_transaction_value
    FROM
        transactions
    WHERE
        transaction_date BETWEEN @StartDate AND @EndDate
    GROUP BY
        payment_method, status
    ORDER BY
        total_amount DESC;
END
GO

-- 6. GetContentDistribution (for Content Gaps Report)
-- Returns material type distribution across topics
-- =============================================
CREATE PROCEDURE GetContentDistribution
    @SubCourseId INT = NULL,
    @TopicId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.type AS material_type,
        COUNT(*) AS material_count,
        COUNT(DISTINCT m.topic_id) AS topics_with_this_type,
        COUNT(DISTINCT t.sub_course_id) AS courses_with_this_type
    FROM
        materials m
    INNER JOIN
        topics t ON m.topic_id = t.topic_id
    WHERE
        (@SubCourseId IS NULL OR t.sub_course_id = @SubCourseId)
        AND (@TopicId IS NULL OR m.topic_id = @TopicId)
    GROUP BY
        m.type
    ORDER BY
        material_count DESC;
END
GO

-- 7. GetDormantUsers (for User Activity Report)
-- Returns users who haven't logged in for specified days
-- =============================================
CREATE PROCEDURE GetDormantUsers
    @DormantDays INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.user_id,
        u.name,
        u.email,
        u.status,
        MAX(uce.enrolled_on) AS last_activity_date,
        DATEDIFF(DAY, MAX(uce.enrolled_on), GETDATE()) AS days_inactive,
        COUNT(uce.enrollment_id) AS total_enrollments
    FROM
        users u
    LEFT JOIN
        user_course_enrollments uce ON u.user_id = uce.user_id
    WHERE
        u.role = 'user'
    GROUP BY
        u.user_id, u.name, u.email, u.status
    HAVING
        DATEDIFF(DAY, MAX(uce.enrolled_on), GETDATE()) > @DormantDays
        OR MAX(uce.enrolled_on) IS NULL
    ORDER BY
        days_inactive DESC;
END
GO

EXEC GetSubCourseCompletionRates;
EXEC GetCourseEnrollmentVsRevenue;
EXEC GetUserEngagementMetrics;
EXEC GetTransactionBreakdown;
EXEC GetContentDistribution;
EXEC GetDormantUsers;
EXEC GetMonthlyUserRegistrations;

-- Test each SP individually
EXEC GetSubCourseCompletionRates;
EXEC GetCourseEnrollmentVsRevenue NULL, NULL;
EXEC GetUserEngagementMetrics 90;
EXEC GetTransactionBreakdown NULL, NULL;
EXEC GetContentDistribution NULL, NULL;
EXEC GetDormantUsers 90;
EXEC GetMonthlyUserRegistrations;

PRINT 'All enhanced stored procedures created successfully!';