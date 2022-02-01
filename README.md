# Pewlett-Hackard-Analysis

## Overview

Pewlett Hackard is reviewing the effect of upcoming retirees.  They have a requested an analysis of the current employees expected to retire (employees born between January 1, 1952 and December 31, 1955).  This analysis includes a count of hte total expected retirees, and a list of the retirees by title.  To combat the effect on lost production, Pewlett Hackard is reviewing potential options to create a mentorship program for new hires.  They have chosen current employees born between January 1, 1965 anf December 31, 1965 as being eligible for the program.  The second part of the analysis was to create  list of mentorship eligible employees and their current titles. PostgresSQL was used with the supplied data to create tables with sql queries to compile the information for analysis.

## Results

### Data Outputs - 

  1. **Queries/Employee_Database_Challenge.sql** - postgresSQL code for sorting and combining Pewlett-Hackard Data
  2. **Data/retirement_titles.csv** - list of all employees on file with brith dates between January 1, 1952 and December 31, 1955.
  3. **Data/unique_titles.csv** - list of all ***current*** employees on file with brith dates between January 1, 1952 and December 31, 1955.
  4. **Data/retiring_titles.csv** - list of all ***current*** employees by their ***currrent titles*** with brith dates between January 1, 1952 and December 31, 1955.
  5. **Data/mentorship_eligibility.csv** - list of all ***current*** employees by their ***currrent titles*** with brith dates between January 1, 1965 and December 31, 1965.
  6. **Data/titles_merged.csv** - combined table for comparing all current employees on file compared to retirees and mentor eligible by title.
  7. **Data/titles_dept_merged.csv** - combined table for all current employees, retiring, and mentor eligible by department and title.
  
### Data Results

  1. Roughly 30% of all current Pewlett Packard employees on file were born between January 1, 1952 and December 31, 1955.
  2. The majority (70%) of the retiring workforce are in senior positions. The largest are Senior Engineer and Senior Staff.
  3. All employees on file had brith dates between **January 1, 1952 and December 31, 1965** making the youngest person on file 56 years old.

  ![image](https://user-images.githubusercontent.com/91850824/151905784-382f5957-df02-4fcf-9ea5-5e3666925208.png)

  
  3. Development (19,391 employees) and Production (17,784 employees) will be the hardest hit by retirement.  The 2 departments represent 50% of the retiring force.
  4. Current Employees with brith dates between January 1, 1965 and December 31, 1965 total 1549 employees only 2% of retiring class.
  5. Mentorship Eligible Employees hold all the same titles as those retiring with the exception of 2 manager positions.
    ![image](https://user-images.githubusercontent.com/91850824/151905541-2ddb0e90-f0f0-4666-b1ed-29f6c025937b.png)

 ## Summary
 
  1.  There were 240,124 current employees in the employees.csv data resource.  There are 72,458 employees born between January 1, 1952 and December 31, 1955.
  
  ![image](https://user-images.githubusercontent.com/91850824/151910190-cca1413e-8e76-49a1-baa8-86cf270235d1.png)

  
  2.  Looking at the mentor eligible employees; although they number 2% of the retiring force, they do appear to cover all areas (with the exception of 2 Manager titles).  Proportionately, the mentor eligible employees appear to mirror the retiring employees; however, the Senior Engineer level appears to be lagging, but there are employees for every title.  To further show coverage, a table was constructed by department and title.  Again the mentor eligible have full coverage across all departments and all titles except manager compared to the retiring employee column.  I would reccomend studying the employee comparison against all departments and titles.  Employees called Engineer would not necessarily make effective trainers in other departments.   

![image](https://user-images.githubusercontent.com/91850824/151910200-4a86f901-ff1a-44ee-8c8b-030eeb6d26a4.png)

![image](https://user-images.githubusercontent.com/91850824/151910499-3ddd85e0-491b-48d2-bb02-99a682771a54.png)

 Reviewing the list areas like Production- Senior Engineers will lose 11256 of 12863 Senior Engineers on file, with only 9 in the mentor category.  Likewisee with Development
Senior Engineers 14671 on staff 12308 leaving, 87 mentor eligible.  The spread of talent appears to be there; however, 30% of your workforce is hard to replace.  The 240,124    employees on file are all over 56 years of age.  I would reccomend expanding the mentor critieria beyond 1965.

