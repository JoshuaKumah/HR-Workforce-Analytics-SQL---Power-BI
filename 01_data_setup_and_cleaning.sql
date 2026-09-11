/*
    Project: HR Workforce Analytics
    File: 01_data_setup_and_cleaning.sql
    Purpose: Create the project database and clean the HR dataset.
    SQL dialect: MySQL
    Author: Joshua Elom Mensah Kumah
    Status: Work in progress
*/


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS hr_analysis;

USE hr_analysis;


-- Preview the imported HR data.

SELECT *
FROM hr;


-- ============================================================
-- 2. DATA CLEANING
-- ============================================================

-- 2.1 Rename the employee ID column.

ALTER TABLE hr
CHANGE COLUMN `ï»¿id` em_id VARCHAR(20) NULL;


-- Inspect the table structure.

DESCRIBE hr;


-- ------------------------------------------------------------
-- 2.2 Convert birthdate from text to a date field.
-- ------------------------------------------------------------

SELECT birthdate
FROM hr;


UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%'
        THEN DATE_FORMAT(
            STR_TO_DATE(birthdate, '%m/%d/%Y'),
            '%Y-%m-%d'
        )
    WHEN birthdate LIKE '%-%'
        THEN DATE_FORMAT(
            STR_TO_DATE(birthdate, '%m-%d-%y'),
            '%Y-%m-%d'
        )
    ELSE NULL
END;


ALTER TABLE hr
MODIFY COLUMN birthdate DATE;


-- ------------------------------------------------------------
-- 2.3 Convert hire_date from text to a date field.
-- ------------------------------------------------------------

SELECT hire_date
FROM hr;


UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%'
        THEN DATE_FORMAT(
            STR_TO_DATE(hire_date, '%m/%d/%Y'),
            '%Y-%m-%d'
        )
    WHEN hire_date LIKE '%-%'
        THEN DATE_FORMAT(
            STR_TO_DATE(hire_date, '%m-%d-%y'),
            '%Y-%m-%d'
        )
    ELSE NULL
END;


ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


-- ------------------------------------------------------------
-- 2.4 Convert termdate from text to a date field.
-- Remove the timestamp and standardise empty values first.
-- ------------------------------------------------------------

SELECT termdate
FROM hr;


UPDATE hr
SET termdate = DATE(
    STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
)
WHERE termdate IS NOT NULL
    AND termdate != '';


UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL
    OR termdate = '';


SELECT termdate
FROM hr;


ALTER TABLE hr
MODIFY COLUMN termdate DATE;


-- ============================================================
-- 3. AGE CALCULATION
-- ============================================================

-- 3.1 Add an age column to the dataset.

ALTER TABLE hr
ADD COLUMN age INT;


-- 3.2 Calculate each employee's age.

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


-- 3.3 Review the age range for unusual values.

SELECT
    MAX(age) AS maximum_age,
    MIN(age) AS minimum_age
FROM hr;


-- 3.4 Apply the dataset-specific birthdate adjustment.

UPDATE hr
SET birthdate = DATE_SUB(birthdate, INTERVAL 18 YEAR);


-- Recalculate age after adjusting birthdate.

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


-- Review the adjusted age range.

SELECT
    MAX(age) AS maximum_age,
    MIN(age) AS minimum_age
FROM hr;


-- Preview the cleaned dataset.

SELECT *
FROM hr;
