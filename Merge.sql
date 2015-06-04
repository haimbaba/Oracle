MERGE
 INTO bonuses b
USING (
 SELECT employee_id, salary, dept_no
 FROM employee
 WHERE dept_no =20) e
ON (b.employee_id = e.employee_id)
WHEN MATCHED THEN
 UPDATE SET b.bonus = e.salary * 0.1 