create database pro;
use pro;
CREATE TABLE Employees (
    employee_id integer PRIMARY KEY,
    name VARCHAR(100),
    contact_details VARCHAR(100),
    department VARCHAR(100),
    designation VARCHAR(100)
);

insert into employees ( employee_id,name,contact_details, department,designation )
              values(1, 'Alice Johnson', 'alice@example.com', 'Marketing', 'Marketing Manager'),
(2, 'Bob Smith', 'bob@example.com', 'Sales', 'Sales Executive'),
(3, 'Charlie Brown', 'charlie@example.com', 'IT', 'Software Engineer'),
(4, 'Dana White', 'dana@example.com', 'HR', 'HR Specialist'),
(5, 'Eva Green', 'eva@example.com', 'Finance', 'Financial Analyst'),
(6, 'Frank Miller', 'frank@example.com', 'Operations', 'Operations Manager'),
(7, 'Grace Lee', 'grace@example.com', 'Customer Service', 'Customer Service Rep'),
(8, 'Henry Davis', 'henry@example.com', 'IT', 'Network Administrator'),
(9, 'Ivy Wilson', 'ivy@example.com', 'Marketing', 'Content Strategist'),
(10, 'Jack Taylor', 'jack@example.com', 'Sales', 'Regional Manager');
select * from Employees;

  CREATE TABLE Attendance (
    attendance_id integer PRIMARY KEY,
    employee_id integer,
    attendance_date DATE,
    in_time TIME,
    out_time TIME,
    status ENUM('Present', 'Absent', 'Leave'),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) 

   );
   INSERT INTO Attendance (attendance_id, employee_id, attendance_date, in_time, out_time,status) VALUES
                          (01, 1, '2024-10-01', ' 09:00:00', '17:00:00','Present'),
                          (02, 2, '2024-10-01', '09:15:00', '17:30:00','Present'),
						              (03, 3, '2024-10-01', '09:00:00', '18:00:00', 'Present'),
                          (04, 4, '2024-10-01', '09:00:00', '18:00:00','Present'),
						              (05, 5, '2024-10-01', '09:30:00', ' 17:00:00', 'Present'),
					                (06, 6, '2024-10-01', '00:00:00', ' 00:00:00','Absent'),
					                (07, 7, '2024-10-01', '09:00:00', ' 17:00:00','Present'),
                          (08, 8, '2024-10-01', '09:10:00', ' 17:10:00','Present'),
                          (09, 9, '2024-10-01', '09:05:00', ' 17:20:00','Present'),
                          (010, 10, '2024-10-01', '0:00:00', '00:00:00','Leave');
                    
                        
                        
select* from Attendance;
CREATE TABLE Payroll (
    payroll_id integer PRIMARY KEY,
    employee_id integer,
    salary integer,
    bonuses integer,
    deductions integer,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
INSERT INTO Payroll (payroll_id, employee_id, salary, bonuses, deductions) VALUES
(1, 1, 60000, 5000, 2000),
(2, 2, 55000, 3000, 1500),
(3, 3, 70000, 7000, 2500),
(4, 4, 48000, 2000, 1000),
(5, 5, 65000, 6000, 2200),
(6, 6, 75000, 8000, 3000),
(7, 7, 45000, 1500, 800),
(8, 8, 72000, 7500, 2700),
(9, 9, 50000, 3500, 1800),
(10, 10, 60000, 5000, 2000);

select * from Payroll; 
CREATE TABLE PerformanceReviews (
    review_id integer PRIMARY KEY,
    employee_id integer,
    review_date DATE,
    rating integer,
    feedback VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
INSERT INTO PerformanceReviews (review_id, employee_id, review_date, rating, feedback) VALUES
(1, 1, '2024-01-15', 4, 'Excellent leadership skills.'),
(2, 2, '2024-01-15', 3, 'Good performance, needs improvement in communication.'),
(3, 3, '2024-01-15', 5, 'Outstanding work ethic and results.'),
(4, 4, '2024-01-15', 4, 'Strong team player.'),
(5, 5, '2024-01-15', 3, 'Good analytical skills, but could be more proactive.'),
(6, 6, '2024-01-15', 5, 'Exceptional contributions to projects.'),
(7, 7, '2024-01-15', 4, 'Great customer service skills.'),
(8, 8, '2024-01-15', 4, 'Effective problem solver.'),
(9, 9, '2024-01-15', 2, 'Needs to improve punctuality and teamwork.'),
(10, 10, '2024-01-15', 3, 'Consistent performance, room for growth.');
select * from  PerformanceReviews; 

 -- UPDATE table    --
UPDATE Employees
SET 
    name = 'Jane',
    contact_details='jane@example.com',
    department= 'HR',
    designation= 'HR Specialist'
WHERE employee_id = 2;
select* from Employees;

-- search by name --
SELECT * FROM Employees
WHERE name LIKE '%Jane%' OR department LIKE '%HR Specialist%';

 -- Calculate Total Working Hours --

SELECT employee_id,attendance_date,
    SUM(TIMESTAMPDIFF(MINUTE, in_time, out_time)) AS total_working_minutes,
    SUM(TIMESTAMPDIFF(HOUR, in_time, out_time)) AS total_working_hours
FROM 
    Attendance
WHERE 
    attendance_date = '2024-10-01' 
    AND status = 'Present'
GROUP BY 
    employee_id, attendance_date;
    
  -- Calculate overtime --   
SELECT employee_id,attendance_date,
    SUM(TIMESTAMPDIFF(HOUR, in_time, out_time)) - 8 AS overtime_hours
FROM 
    Attendance
WHERE 
    attendance_date = '2024-10-01'  
    AND status = 'Present'
GROUP BY 
    employee_id, attendance_date;
  
  -- attendance report --   
SELECT 
    employee_id,
    COUNT(*) AS total_days_present,
    COUNT(CASE WHEN status = 'Leave' THEN 1 END) AS total_leave_days,
    (COUNT(CASE WHEN status = 'Present' THEN 1 END) / COUNT(*)) * 100 AS attendance_percentage
FROM 
    Attendance
WHERE 
    attendance_date BETWEEN '2024-10-01' AND '2024-10-31'  -- Replace with your desired date range
GROUP BY 
    employee_id;
 
