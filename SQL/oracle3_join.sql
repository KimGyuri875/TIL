--1. ORDER BY
--2. GROUP BY
--3. HAVING
--4. JOIN
--  (1). JOIN USING
--  (2). JOIN ON
--  (3). OUTER JOIN : LEFT|FIGHT JOIN, FULL OUTER JOIN
--  (4). CROSS JOIN
--  (5). NON EQUIJOIN
--  (6). SELF JOIN
-- ORDER BY 기준 1 [ASC | DESC], 기준2 [ACS | DESC] 오름차순 내림차순
-- 항상 SELECT 구문의 맨 마지막에 위치

-- GROUP BY
-- GROUP BY 절에 기술한 컬럼/표현식을 기준으로 데이터 그룹 생성
-- 각 그룹별로 SELECT 절에 기술한 그룹 함수가 적용
-- WHERE 절에는 그룹 함수를 사욯할 수 없음
-- GROUP BY 절에는 컬럼 이름만 사용 가능(별칭, 순서 사용 불가)
-- SELECT 절에 기술한 컬럼 중, 그룹 함수에 사용되지 않은 컬럼은, GROUP BY 절에 반드시 기술되어야 함
-- 즉, GROUP BY를 SELECT을 쓰면 모든 SELECT에 기술된 컬럼은 GROUP BY 컬럼이거나 그룹함수여야함.
SELECT      DEPT_ID, COUNT(*)
FROM        EMPLOYEE
GROUP BY    DEPT_ID 
ORDER BY    1;

SELECT      EMP_NAME, DEPT_ID, COUNT(*)
FROM        EMPLOYEE
GROUP BY    EMP_NAME, DEPT_ID;
 
 -- HAVING : GROUP BY 에 의해 그룹화 된 데이터에 대한 그룹 함수 실행 결과를 제한하기 위해 사용 (WHERE는 원본 데이터 제한)
 
-- JOIN, INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN

-- JOIN USING : 조인 조건으로 사용하는 컬럼 이름이 동일한 경우 사용, 별칭 사용할 수 없음
SELECT EMP_NAME, LOC_ID
FROM EMPLOYEE2
JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);

-- JOIN ON : 조인 조건으로 사용하는 컬럼 이름이 서로 다른 경우 사용
SELECT DEPT_NAME, LOC_DESCRIBE
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- OUTER JOIN : 조건을 만족시키지 못하는 행까지 RESULT SET에 포함시키는 조인 유형
-- OUTER JOIN : 합집합, LEFT JOIN, RIGHT JOIN, FULL JOIN
-- 이때 left와 outer를 정하는 기준은 FROM절에 적어준 테이블이 left가 되고, 
-- JOIN절에 적어준 테이블이 right가 됩니다. 
-- WHERE E.DEPT_ID = D.DEPT_ID(+); 와 같은 의미
-- 정보가 없는 직원을 결과에 포함하려면 OUTER JOIN을 사용해야 함
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY 1;

-- JOIN - NON EQUIJOIN
SELECT EMP_NAME, SALARY, SLEVEL 
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY 3;

-- SELF JOIN: 테이블 별칭을 사용해야 함
SELECT      E.EMP_NAME AS 직원,
            M.EMP_NAME AS 관리자
FROM        EMPLOYEE E
JOIN        EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
ORDER BY    1;

-- FULL OUTER JOIN : 
-- INNER JOIN: 교집합
--조인시에 table1과 table2의 어떤 컬럼을 기준으로 할지는 ON 뒤에 작성합니다.
-- JOIN table2 ON table2.col1 = table2.col2

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
