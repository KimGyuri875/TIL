-- JOIN, INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN

-- INNER JOIN: ������
--���νÿ� table1�� table2�� � �÷��� �������� ������ ON �ڿ� �ۼ��մϴ�.
-- JOIN table2 ON table2.col1 = table2.col2

-- OUTER JOIN : ������, LEFT JOIN, RIGHT JOIN, FULL JOIN
--�̶� left�� outer�� ���ϴ� ������ FROM���� ������ ���̺��� left�� �ǰ�, 
--JOIN���� ������ ���̺��� right�� �˴ϴ�. 
--
select employee.empName, department.deptName
from employee
left outer join department on employee.deptNo = department.deptNo;
-- ��ġ�ϴ� EMPLOYEE.EMPNAME�� ��� ��µǵ��� 

-- CROSS JOIN

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN LOWEST AND HIGHEST;

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN LOWEST AND HIGHEST);

