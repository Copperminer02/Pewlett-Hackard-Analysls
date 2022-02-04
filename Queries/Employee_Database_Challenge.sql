-- Drop Table if it does not exist
DROP TABLE IF EXISTS retirement_titles;

-- Create new table to hold current employee names and titles due to retire
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Review retirement_titles before exporting as csv retirement_titles.csv
SELECT * FROM retirement_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS unique_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Review unique_titles before exporting as csv retirement_titles.csv
SELECT * FROM unique_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS retiring_titles;

-- Count the number of potential retirees by current job title
SELECT COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Review retiring_titles before exporting as csv retirement_titles.csv
SELECT * FROM retiring_titles;

-- PART 2 Challenge

-- Drop Table if it does not exist
DROP TABLE IF EXISTS mentor_titles;

-- Create new table to hold current employee names and titles in mentor category
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	t.from_date,
	t.to_date,
	t.title
INTO mentor_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Review retirement_titles
SELECT * FROM mentor_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS mentorship_eliginility;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	birth_date,
	from_date,
	to_date,
	title
INTO mentorship_eliginility
FROM mentor_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Review mentorship_eliginility before exporting as csv retirement_titles.csv
SELECT * FROM mentorship_eliginility;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Drop Table if it does not exist
DROP TABLE IF EXISTS retirees_by_title_dept;

-- Determine how many employees, what department, and what position are ready for retirement
-- group retirees and titles to deprtment name
SELECT DISTINCT ON(u.emp_no) u.emp_no,
	u.title,
	de.dept_no,
	d.dept_name
INTO retirees_by_title_dept
FROM unique_titles AS u
INNER JOIN dept_emp as de
ON u.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY u.emp_no,u.title,de.dept_no,d.dept_name;

SELECT * FROM retirees_by_title_dept;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS titles_by_dept_retirees;

-- count titles for retiree group by department
SELECT r.dept_name,
	r.title,
	COUNT(title)
INTO titles_by_dept_retirees
FROM retirees_by_title_dept AS r
GROUP BY r.dept_name,r.title;	

SELECT * FROM titles_by_dept_retirees;


-- Drop Table if it does not exist
DROP TABLE IF EXISTS mentorship_titles;

-- Count the number of potential mentorees by current job title
SELECT COUNT(title),
	title
INTO mentorship_titles
FROM mentorship_eliginility
GROUP BY title
ORDER BY count DESC;

SELECT * FROM mentorship_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS mentorees_by_title_dept;

-- Sort mentorship candidates by department and title
SELECT DISTINCT ON(me.emp_no) me.emp_no,
	me.title,
	de.dept_no,
	d.dept_name
INTO mentorees_by_title_dept
FROM mentorship_eliginility AS me
INNER JOIN dept_emp as de
ON me.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY me.emp_no,me.title,de.dept_no,d.dept_name;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS titles_by_dept_mentors;

-- group titles by department name 
SELECT mt.dept_name,
	mt.title,
	COUNT(title)
INTO titles_by_dept_mentors
FROM mentorees_by_title_dept AS mt
GROUP BY mt.dept_name,mt.title;	


SELECT * FROM titles_by_dept_mentors;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS current_titles;

-- Find total current employees in employees file
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	t.from_date,
	t.to_date,
	t.title
INTO current_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
ORDER BY e.emp_no;

-- Review current_titles
SELECT * FROM current_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS unique_current_titles;

-- Find total current unique employees in employees file
SELECT DISTINCT ON (c.emp_no) c.emp_no,
	c.title,
	de.dept_no,
	d.dept_name
INTO unique_current_titles
FROM current_titles AS c
INNER JOIN dept_emp as de
ON c.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE c.to_date = '9999-01-01'
ORDER BY c.emp_no, c.to_date DESC;

SELECT * FROM unique_current_titles;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS all_titles;

-- Sort all current employees by title
SELECT COUNT(title),
	title
INTO all_titles
FROM unique_current_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM all_titles;


-- Drop Table if it does not exist
DROP TABLE IF EXISTS current_by_title_dept;

SELECT DISTINCT ON(u.emp_no) u.emp_no,
	u.title,
	de.dept_no,
	d.dept_name
INTO current_by_title_dept
FROM unique_current_titles AS u
LEFT JOIN dept_emp as de
ON u.emp_no = de.emp_no
LEFT JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY u.emp_no,u.title,de.dept_no,d.dept_name;

SELECT * FROM current_by_title_dept;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS titles_by_dept_current;

-- count titles for retiree group by department
SELECT c.dept_name,
	c.title,
	COUNT(title)
INTO titles_by_dept_current
FROM current_by_title_dept AS c
GROUP BY c.dept_name,c.title;	

SELECT * FROM titles_by_dept_current;

-- Drop table if exists
DROP TABLE IF EXISTS titles_mergred;

-- Merge all tables by that sort employees by titles only
SELECT r.title,
	a.count AS all_employees,
	r.count AS retiring_employees,
	m.count AS mentor_eligible
INTO titles_mergred
FROM retiring_titles AS r
LEFT JOIN mentorees_by_title_dept AS m
ON r.title = m.title
LEFT JOIN all_titles AS a
ON r.title = a.title
GROUP BY r.title,a.count,r.count
ORDER BY r.title ASC;

SELECT * FROM titles_mergred;

-- Drop Table if it does not exist
DROP TABLE IF EXISTS titles_dept_merged;

-- Merge all tables that combine all employees by title and by deparment

SELECT c.dept_name,
	c.title,
	c.count AS "all_employees",
	r.count AS "retiring_employees",
	m.count AS "mentor_eligible"
INTO titles_dept_merged
FROM titles_by_dept_current AS c
LEFT JOIN titles_by_dept_retirees AS r
ON c.dept_name = r.dept_name
AND c.title = r.title
LEFT JOIN titles_by_dept_mentors AS m
ON c.dept_name = m.dept_name
AND c.title = m.title
ORDER BY c.dept_name ASC;

SELECT * FROM titles_dept_merged;