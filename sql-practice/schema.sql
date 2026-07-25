create database company_db;
create table department(
    dept_id INT PRIMARY KEY
    dept_name varchar(50)
);
create table employee(
    emp_id int primary key,
    emp_name varchar(50),
    salary int,
    dept_id int,
    foreign key(dept_id) references department(dept_id)
);