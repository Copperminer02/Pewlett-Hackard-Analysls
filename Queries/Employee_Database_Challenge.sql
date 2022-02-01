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

-- Count the number of potential retirees by current job title
SELECT COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Review retiring_titles before exporting as csv retirement_titles.csv
SELECT * FROM retiring_titles;

-- Querry the employees available for mentorship programs born between January 1, 1965 and December 31,1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eliginility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON de.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eliginility;
-- EXTRA Tables for Module Challenge
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Determine how many employees, what department, and what position are ready for retirement
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

SELECT r.dept_name,
	r.title,
	COUNT(title)
INTO titles_by_dept_retirees
FROM retirees_by_title_dept AS r
GROUP BY r.dept_name,r.title;	

SELECT * FROM titles_by_dept_retirees;
	
-- Count the number of potential mentorees by current job title
SELECT COUNT(title),
	title
INTO mentorship_titles
FROM mentorship_eliginility
GROUP BY title
ORDER BY count DESC;

SELECT * FROM mentorship_titles;

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


SELECT mt.dept_name,
	mt.title,
	COUNT(title)
INTO titles_by_dept_mentors
FROM mentorees_by_title_dept AS mt
GROUP BY mt.dept_name,mt.title;	


SELECT * FROM titles_by_dept_mentors;

-- Find total current employees in employees file
SELECT e.emp_no,
	t.title,
	de.to_date,
	de.dept_no
INTO current_titles
FROM employees AS e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN titles AS t
ON e.emp_no = t.emp_no




-- Find total current unique employees in employees file
SELECT DISTINCT ON (c.emp_no) c.emp_no,
	c.title,
	c.dept_no,
	d.dept_name
INTO unique_current_titles
FROM current_titles AS c
INNER JOIN departments AS d
ON c.dept_no = d.dept_no
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_current_titles;


-- Sort all current employees by title
SELECT COUNT(title),
	title
INTO all_titles
FROM unique_current_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM all_titles;

-- Sort all current employees by by totals by department and by title
SELECT dept_name,
	title,
	COUNT(title)
INTO titles_by_dept_current
FROM unique_current_titles AS u
GROUP BY dept_name,title;	

SELECT * FROM titles_by_dept_current;

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
-- Merge all tables that combine all employees by title and by deparment

SELECT c.dept_name,
	c.title,
	c.count AS all_employees,
	r.count AS retiring_employees,
	m.count AS mentor_eligible
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