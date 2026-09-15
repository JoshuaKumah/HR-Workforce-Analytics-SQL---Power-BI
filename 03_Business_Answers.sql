-- ============================================================
-- HR DATA ANALYSIS
-- Business Questions and SQL Queries
-- ============================================================


-- ------------------------------------------------------------
-- 1. What is the gender breakdown of current employees?
-- ------------------------------------------------------------

SELECT
    gender,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY gender
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 2. What is the race/ethnicity breakdown of current employees?
-- ------------------------------------------------------------

-- Check available race/ethnicity categories
SELECT DISTINCT race
FROM hr;

-- Distribution of current employees by race/ethnicity
SELECT
    race,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY race
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 3. What is the age distribution of current employees?
-- ------------------------------------------------------------

SELECT
    CASE
        WHEN age < 20 THEN 'Below 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        ELSE '40+'
    END AS age_group,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;


-- Age distribution by gender

SELECT
    CASE
        WHEN age < 20 THEN 'Below 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        ELSE '40+'
    END AS age_group,
    gender,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- ------------------------------------------------------------
-- 4. How many employees work at headquarters vs. remote?
-- ------------------------------------------------------------

-- Check available location categories
SELECT DISTINCT location
FROM hr;

-- Current employees by work location
SELECT
    location,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY location
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 5. What is the average length of employment for terminated
--    employees?
-- ------------------------------------------------------------

SELECT
    ROUND(
        AVG(TIMESTAMPDIFF(YEAR, hire_date, termdate)),
        2
    ) AS avg_employment_length_years
FROM hr
WHERE termdate <> '0000-00-00'
  AND termdate <= CURDATE();


-- ------------------------------------------------------------
-- 6. How does gender distribution vary across departments
--    and job titles?
-- ------------------------------------------------------------


-- 6a. Gender distribution by department

SELECT
    department,
    gender,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department, employee_count DESC;


-- 6b. Gender distribution by job title

SELECT
    jobtitle,
    gender,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY jobtitle, gender
ORDER BY jobtitle, employee_count DESC;


-- ------------------------------------------------------------
-- 7. What is the distribution of job titles across the company?
-- ------------------------------------------------------------

SELECT
    jobtitle,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 8. Which department has the highest turnover rate?
-- ------------------------------------------------------------
-- Turnover rate is calculated as:
-- terminated employees / total employees in the department

SELECT
    department,
    total_count,
    terminated_count,
    ROUND(
        terminated_count / total_count * 100,
        2
    ) AS termination_rate_percent
FROM (
    SELECT
        department,
        COUNT(*) AS total_count,
        SUM(
            CASE
                WHEN termdate <> '0000-00-00'
                     AND termdate <= CURDATE()
                THEN 1
                ELSE 0
            END
        ) AS terminated_count
    FROM hr
    GROUP BY department
) AS department_turnover
ORDER BY termination_rate_percent DESC;


-- ------------------------------------------------------------
-- 9. What is the distribution of current employees by state?
-- ------------------------------------------------------------

SELECT
    location_state,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY location_state
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 10. How has employee headcount changed over time based on
--     hires and terminations?
-- ------------------------------------------------------------

SELECT
    year,
    hires,
    terminations,
    hires - terminations AS net_change,
    ROUND(
        (hires - terminations) / hires * 100,
        2
    ) AS net_change_percent
FROM (
    SELECT
        YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(
            CASE
                WHEN termdate <> '0000-00-00'
                     AND termdate <= CURDATE()
                THEN 1
                ELSE 0
            END
        ) AS terminations
    FROM hr
    GROUP BY YEAR(hire_date)
) AS yearly_employee_changes
ORDER BY year DESC;


-- ------------------------------------------------------------
-- 11. What is the average tenure of terminated employees
--     by department?
-- ------------------------------------------------------------

SELECT
    department,
    ROUND(
        AVG(TIMESTAMPDIFF(YEAR, hire_date, termdate)),
        2
    ) AS avg_tenure_years
FROM hr
WHERE termdate <> '0000-00-00'
  AND termdate <= CURDATE()
GROUP BY department
ORDER BY avg_tenure_years DESC;
