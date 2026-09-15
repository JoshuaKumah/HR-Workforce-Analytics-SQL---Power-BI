HR Workforce Analytics | SQL & Power BI

Project overview

This end-to-end portfolio project uses MySQL to clean, transform, and analyse an employee dataset, followed by Power BI to communicate the findings through an interactive workforce dashboard.

The project is designed to demonstrate practical skills in:

SQL data cleaning and transformation

Exploratory workforce analysis

Aggregate functions and conditional logic

Date conversion and employee-tenure calculations

Business-question development

Data export and preparation for Power BI

Dashboard design and data storytelling



Business objective

The analysis aims to help an organisation understand its workforce composition, diversity, working arrangements, employee tenure, turnover, geographic distribution, and headcount trends.

Business questions

1.What is the gender breakdown of employees in the company?

2.What is the race and ethnicity breakdown of employees?

3. What is the age distribution of employees in the company?

4. How many employees work at headquarters compared with remote locations?

5. What is the average length of employment for terminated employees?

6. How does gender distribution vary across departments and job titles?

7. What is the distribution of job titles across the company?

8. Which department has the highest turnover rate?

9. How are employees distributed across locations by city and state?

Data-cleaning process

The SQL cleaning workflow currently covers:

1. Renaming the employee identifier column

2. Inspecting column names and data types

3. Converting birthdate from text to a date field

4. Converting hire_date from text to a date field

5. Removing timestamps from termdate

6. Converting termdate into a date field

7. Creating an employee age column

8. Reviewing minimum and maximum ages for anomalies

9. Applying a dataset-specific birthdate adjustment

Tools:

MySQL: database creation, cleaning, transformation, and analysis

MySQL Workbench: query development and result export

Power BI: data modelling, KPI development, visualisation, and storytelling

GitHub: project documentation and version control

How to use this project

Create or connect to a MySQL environment.

Import the HR source file as a table named hr.

Run sql/01_data_setup_and_cleaning.sql.

Run sql/02_business_questions.sql.

Run sql/03_business_questions.sql.

Export each final query result using the filenames suggested in exports/README.md.

Load the exported results into Power BI.

Add the completed .pbix file to the powerbi folder.

Export a dashboard screenshot and add it to the images folder.


What is the tenure distribution for each department?
