Background
===
![](https://github.com/willesco16/PYTHON-SQL-ETL-Project/raw/master/Images/sql.png)

Conduct a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

Design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, perform the following:

1. Data Modeling
2. Data Engineering
3. Data Analysis

## Objectives

### Data Modeling
Inspect the CSVs and sketch out an ERD of the tables using QuickDBD
![](https://github.com/willesco16/PYTHON-SQL-ETL-Project/raw/master/Images/ERD1.png)

### Data Engineering
* Use the information to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.
* Import each CSV file into the corresponding SQL table.

```
CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      VARCHAR(1) 		NOT NULL,
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     VARCHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE   	(dept_name)
);

CREATE TABLE dept_manager (
   dept_no      VARCHAR(4)         NOT NULL,
   emp_no       INT             NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     VARCHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
);

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
);
```
### Data Analysis
Once there is a complete database, do the following:

1. Salary by employee.
```
select  employees.emp_no, 
        employees.last_name, 
        employees.first_name, 
        employees.gender, 
        salaries.salary
from employees as emp
    LEFE join salaries as sal
    on (emp.emp_no = sal.emp_no)
order by emp.emp_no;
```

2. Employees hired in 1986
```
select * from employees
where hire_date LIKE '1986%'
```

3. Manager of each department. Show Results
```
select dm.dept_no as "Department Number", 
       d.dept_name as "Department Name", 
       dm.emp_no as "Manager Employee Number", 
       e.first_name as "Fist Name", 
       e.last_name as "Last Name",
       dm.from_date as "Start Dates", 
       dm.to_date as "End Dates"
       
from dept_manager as dm
    inner join departments as d
    on (d.dept_no = dm. dept_no
    inner join employees as e
    on (dm.emp_no = e.emp_no);
```

4. Department of each employee. Show Results
```
select dm.emp_no as "Employee Number", 
       e.first_name as "Fisrt Name", 
       e.last_name as "Last Name",
       d.dept_name as "Department Name"
        
from employees as e
    inner join dept_emp as de
        on (e.emp_no = de.emp_no)
    inner join departments as d
        on (de.dept_no = d.dept_no)
order by e.emp_no;
```

5. Employees whose first name is "Hercules" and last name begins with "B". Show Results

```
select * from employees 
where last_name like 'B%' 
and first_name = 'Hercules';
```

6. Employees in the Sales department. Show Results
```
select e.emp_no as "Employee Number", 
        e.first_name as "First Name", 
        e.last_name as "Last Name", 
        d.dept_name as "Department Name"
        
from employees as e
    inner join dept_emp as de
        on (e.emp_no = de.emp_no)
    inner join departments as d
        on (de.dept_no = d.dept_no)
where d.dept_name = 'Sales'
order by e.emp_no;
```

7. Employees in Sales and Development departments. Show Results
```
select e.emp_no as "Employee Number", 
        e.first_name as "First Name", 
        e.last_name as "Last Name", 
        d.dept_name as "Department Name"
from dept_manager as dm
join employees as e 
        on e.emp_no = dm.emp_no
inner join departments as d
        on d.dept_no = dm.dept_no
where d.dept_name in ('Sales','Development')
```
8. The frequency of employee last names. Show Results
```
select last_name,
count (last_name) AS "frequency"
from employees
group by last_name
order by count(last_name) DESC;
```

### Data visualization
1. Import the SQL database into Pandas.
2. Create a bar chart of average salary by title.
3. Include a full technical report in markdown format, in which outline the data engineering steps taken in the data visualization process.
![](https://github.com/willesco16/PYTHON-SQL-ETL-Project/raw/master/Images/salary.png)

