/*
    Project: HR Workforce Analytics
    File: 02_business_questions.sql
    Purpose: Answer workforce-related business questions using cleaned HR data.
    SQL dialect: MySQL
    Author: Joshua Elom Mensah Kumah
  
*/


USE hr_analysis;


-- ============================================================
-- QUESTION 1
-- What is the gender breakdown of employees in the company?
-- Suggested export: 01_gender_breakdown.csv
-- ============================================================

SELECT
    gender,
    COUNT(*) AS gender_group_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY gender;


-- ============================================================
-- QUESTION 2
-- What is the race and ethnicity breakdown of employees?
-- Suggested export: 02_race_ethnicity_breakdown.csv
-- ============================================================

SELECT DISTINCT race
FROM hr;


SELECT
    race,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY race;


-- ============================================================
-- QUESTION 3
-- What is the age distribution of employees in the company?
-- Suggested exports:
--   03_age_distribution.csv
--   03b_age_distribution_by_gender.csv
-- ============================================================

SELECT
    CASE
        WHEN age < 20 THEN 'Below 20'
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 30 AND 40 THEN '30-40'
        ELSE '40+'
    END AS age_distribution,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY age_distribution
ORDER BY age_distribution;


SELECT
    CASE
        WHEN age < 20 THEN 'Below 20'
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 30 AND 40 THEN '30-40'
        ELSE '40+'
    END AS age_group,
    gender,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY
    age_group,
    gender
ORDER BY
    age_group,
    gender;


-- ============================================================
-- QUESTION 4
-- How many employees work at headquarters versus remote locations?
-- Suggested export: 04_work_location_distribution.csv
-- ============================================================

SELECT DISTINCT location
FROM hr;


SELECT
    location,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY location;


-- ============================================================
-- QUESTION 5
-- What is the average length of employment for terminated employees?
-- Suggested export: 05_average_terminated_tenure.csv
-- ============================================================

SELECT
    AVG(TIMESTAMPDIFF(YEAR, hire_date, termdate))
        AS average_employment_length_years
FROM hr;


-- ============================================================
-- QUESTION 6
-- How does gender distribution vary across departments and job titles?
-- Suggested exports:
--   06a_gender_by_department.csv
--   06b_gender_by_job_title.csv
-- ============================================================

-- 6.1 Gender distribution by department.

SELECT
    gender,
    COUNT(*) AS employee_count,
    department
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY
    gender,
    department
ORDER BY employee_count DESC;


-- 6.2 Gender distribution by job title.

SELECT
    gender,
    COUNT(*) AS employee_count,
    jobtitle
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY
    gender,
    jobtitle
ORDER BY employee_count DESC;


-- ============================================================
-- QUESTION 7
-- What is the distribution of job titles across the company?
-- Suggested export: 07_job_title_distribution.csv
-- ============================================================

SELECT
    jobtitle,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY employee_count DESC;


-- ============================================================
-- QUESTION 8
-- Which department has the highest turnover rate?
-- Suggested export: 08_department_turnover_rate.csv
-- Status: TODO
-- ============================================================


-- ============================================================
-- QUESTION 9
-- How are employees distributed across locations by city and state?
-- Suggested export: 09_employee_geography.csv
-- Status: TODO
-- ============================================================


-- ============================================================
-- QUESTION 10
-- How has the company's employee count changed over time based on
-- hire and termination dates?
-- Suggested export: 10_employee_count_over_time.csv
-- Status: TODO
-- ============================================================


-- ============================================================
-- QUESTION 11
-- What is the tenure distribution for each department?
-- Suggested export: 11_department_tenure_distribution.csv
-- Status: TODO
-- ============================================================

