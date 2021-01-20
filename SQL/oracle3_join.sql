-- JOIN, INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN

-- INNER JOIN: 교집합
--조인시에 table1과 table2의 어떤 컬럼을 기준으로 할지는 ON 뒤에 작성합니다.
-- JOIN table2 ON table2.col1 = table2.col2

-- OUTER JOIN : 합집합, LEFT JOIN, RIGHT JOIN, FULL JOIN
--이때 left와 outer를 정하는 기준은 FROM절에 적어준 테이블이 left가 되고, 
--JOIN절에 적어준 테이블이 right가 됩니다. 
--
select employee.empName, department.deptName
from employee
left outer join department on employee.deptNo = department.deptNo;
-- 일치하는 EMPLOYEE.EMPNAME이 없어도 출력되도록 

-- CROSS JOIN

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN LOWEST AND HIGHEST;

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN LOWEST AND HIGHEST);

