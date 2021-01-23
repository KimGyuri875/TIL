--SET operator : UNION, UNION ALL, INTERSECT, MINUS
-- �ΰ� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������ 
-- SELECT ���� ����ϴ� �÷� ������ ������ Ÿ���� ��� �������� �����ؾ���

--UNION : �ߺ������ �ѹ�
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
UNION
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

--UNION ALL: �ߺ������ �� ǥ��

--INTERSECT : ������
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

--MINUS: ������
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
MINUS
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- �����Ͱ����� �����ϱ� ���ؼ� NULL, DUMMY �� �־��ش�
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL
FROM DEPARTMENT
WHERE DEPT_ID = '20';

--UNION 50�� �μ����� ������ �������� �����Ͽ� ǥ���ϰ� �ʹٸ�?
SELECT  EMP_ID, EMP_NAME, '������' AS ����
FROM    EMPLOYEE
WHERE   MGR_ID IS NULL AND DEPT_ID='50'
UNION
SELECT  EMP_ID, EMP_NAME, '����' AS ����
FROM    EMPLOYEE
WHERE   MGR_ID IS NOT NULL AND DEPT_ID='50'
ORDER BY 3;

-- ����(JOB_TITLE)�� �븮 �Ǵ� ��� ������ ��ȸ(�̸�, ����)
--UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '���';

SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE IN ('���', '�븮');

--SUBQUERY
--()�� ��� ǥ��, 
-- SELECT ,FROM, WHERE, HAVING �� ��� ��밡��
-- ���� �� ��������, ���� �� �������� ������ CHECK �ؾ��Ѵ�. 
-- �����̸� �񱳿����ڵ� ��밡��, �������� IN, ANY, ALL�� �ַ� ����Ѵ�. 


-- ���¿��� ����(JOB_ID)�� �����ϰ� ���¿����� �޿��� ���� ����� �̸�, ����, �޿��� ��ȸ�϶�
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID
FROM EMPLOYEE
WHERE EMP_NAME='���¿�')
AND SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME='���¿�');

-- �ּұ޿��� �޴� ����� �̸�, ����, �޿��� ��ȸ

SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE )
                
-- �μ��� �޿� ������ ���� ū �μ��� �̸�, �޿������� ��ȸ

SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID)
                        
-- IN, NOT IN ,ANY, ALL �����ڵ� ������ ������������ ����� �� �ִ�.
-- NOT IN �� ������� NULL�� ���ԵǾ �ȵȴ�. �ȱ׷��� ��ü�� NULL�� ����Ѵ�. 
SELECT EMP_ID, EMP_NAME, '������' AS ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION
SELECT EMP_ID, EMP_NAME, '����' AS ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE WHERE MGR_ID IS NOT NULL)

--�� ���� �ڵ带 �ٸ� ������� �����Ѵٸ�?
SELECT EMP_ID, EMP_NAME, 
    CASE 
        WHEN EMP_ID IN(SELECT MGR_ID FROM EMPLOYEE) THEN '������' 
    ELSE '����' 
    END
FROM EMPLOYEE

SELECT EMP_ID, EMP_NAME, 
    CASE 
        WHEN MGR_ID IS NOT NULL THEN '����' 
    ELSE '������' 
    END AS ����
FROM EMPLOYEE

-- < ANY : �� ��� �� �ִ� ������ ����
-- > ANY : �� ��� �� �ּ� ������ ŭ
-- = ANY : �����ڿ� ����

-- < ALL : �� ��� �� �ּҰ� ���� ����
-- > ALL : �� ��� �� �ִ� �� ���� ŭ

SELECT EMP_NAME, SALARY 
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
    AND SALARY > ANY ( SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_ID) WHERE JOB_TITLE = '����')


SELECT EMP_NAME, SALARY 
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
    AND SALARY > ALL ( SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_ID) WHERE JOB_TITLE = '����')

--�ڱ� ������ ��� �޿��� �޴� ������ ��ȸ�϶�
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                FROM EMPLOYEE
                GROUP BY JOB_ID)

SELECT JOB_TITLE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
GROUP BY JOB_TITLE

SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) AS JOB_AVG
        FROM EMPLOYEE
        GROUP BY JOB_ID) V
JOIN EMPLOYEE E ON(V.JOB_ID = E.JOB_ID AND V.JOB_AVG = E.SALARY)
JOIN JOB J ON(E.JOB_ID = J.JOB_ID)

-- ������� ��������(CORRELATED SUBQUERY)
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                FROM EMPLOYEE
                WHERE JOB_ID = E.JOB_ID)
        
-- EXISTS, NOT EXISTS
-- EXISTS : �����ϸ� TRUE, NOT EXISTS : �������� ������ TRUE
SELECT EMP_ID, EMP_NAME,'������' AS ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID)
UNION
SELECT EMP_ID, EMP_NAME, '����' AS ����
FROM EMPLOYEE E2
WHERE NOT EXISTS (SELECT NULL
                    FROM EMPLOYEE
                    WHERE E2.EMP_ID = MGR_ID)
ORDER BY 3;

