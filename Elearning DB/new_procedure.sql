-- Number of active subcourses for admin dashboard
CREATE PROCEDURE CountActiveSubCourses
AS
BEGIN
    SELECT COUNT(*) AS ActiveSubCourses
    FROM sub_courses
    WHERE status = 'active';
END
GO

b   
-- Number of enrolled users for admin dashboard
CREATE PROCEDURE CountEnrolledUsers
AS
BEGIN
    SELECT COUNT(DISTINCT user_id) AS EnrolledUsers
    FROM user_course_enrollments;
END
GO


-- Drop procedure example



-- Total revenue where status = success
CREATE PROCEDURE GetTotalRevenue
AS
BEGIN
    SELECT ISNULL(SUM(amount), 0) AS TotalRevenue
    FROM transactions
    WHERE status = 'success';
END
GO


-- Get Pending Subscriptions
CREATE PROCEDURE CountPendingSubscriptions
AS
BEGIN
    SELECT ISNULL(COUNT(*), 0) AS PendingSubscriptions
    FROM transactions
    WHERE subscription_id IS NOT NULL
      AND status = 'pending';
END
GO


-- Number of Inactive Users
CREATE PROCEDURE GetInactiveUsersCount
AS
BEGIN
    SELECT COUNT(*) AS InactiveUsers
    FROM users
    WHERE status = 'inactive';
END
GO


-- Inactive master and subcourses
CREATE PROCEDURE GetInactiveCoursesCount
AS
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM master_courses WHERE status = 'archived') +
        (SELECT COUNT(*) FROM sub_courses WHERE status = 'archived')
        AS InactiveCourses;
END
GO
