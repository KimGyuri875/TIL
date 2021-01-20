--1. �Լ�
--2. ORDER BY
--3. GROUP BY
--4. HAVING
SELECT [Ư�� �÷� | * (��ü�÷�) | ǥ���� | DISTINCT | AS �÷���Ī
FROM ���̺� �̸�
WHERE ���ǽ�
GROUP BY ���� �÷�
HAVING ���ǽ�
ORDER BY �����÷�;
--ORBER BY �� �׻� ������

--1. �Լ�: ���ڿ� �Լ�, ���� �Լ�, ��¥ �Լ�, Ÿ�Ժ�ȯ �Լ�, ��Ÿ�Լ�
--(1) ���ڿ� �Լ�: LENGTH, LPAD/RPAD, INSTR, LTIRM/RTIRM/TRIM, SUBSTR

--LENGTH() : NUMBER�� ��ȯŸ��, ���ڿ��� ���̸� ��ȯ
SELECT CHARTYPE, LENGTH(CHARTYPE), VARCHARTYPE, LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;
-- CHAR(��������), VARCHAR2(��������), (�ַ� VARCHAR2�� ����Ѵ�)
-- CHAR TYPE : ���� ������ ���̿� ������� �÷� ��ü ���̸� ��ȯ
-- VARCHAR2 : ���� ������ ���� ��ȯ 

--INSTR() : ã�� ����(��)�� ������ ��ġ���� ������ ȸ����ŭ ��Ÿ�� ���� ��ġ�� ��ȯ�ϴ� �Լ�
-- INSTR(���ڿ�, ã������ ����, ���� ��ġ, ���� ���°�� �߰ߵǴ�)
SELECT EMAIL,
INSTR( EMAIL,'c',-1,2 ) ��ġ
FROM EMPLOYEE ;

SELECT EMAIL,
INSTR( EMAIL, 'c', INSTR( EMAIL,'.' )-1 ) ��ġ
FROM EMPLOYEE ;
-- '.'�� ��ġ�� ���� ã�� �� ��ġ���� �� �ڸ��� ��.

--LPAD, RPAD(STRING, N ,[STR]) : �÷�/���ڿ��� ������ ����(��)�� ����/�����ʿ� ���ٿ� ����� ���� N�� ���ڿ��� ��ȯ
SELECT EMAIL AS ����������,
 LENGTH(EMAIL) AS ��������,
 LPAD(EMAIL, 20, '.') AS ������,
 LENGTH(LPAD(EMAIL, 20, '.')) AS �������
FROM EMPLOYEE;

--LTIRM/RTRIM/TRIM : �÷�/���ڿ��� ����/�����ʿ��� ������ STR�� ���Ե� ��� ���ڸ� ������ �������� ��ȯ�ϴ� �Լ�
-- ������ �����ϴ� �ǹ̰� �ƴ�
SELECT LTRIM('...TECH') FROM DUAL;
SELECT LTRIM('...TECH','.') FROM DUAL;
SELECT LTRIM('6748TECH', '0123456789') FROM DUAL;
SELECT LTRIM('1234TECH123', '1234') FROM DUAL;
--��� : TECH123
SELECT TRIM('   TECH   ') FROM DUAL;
 --TRIM( LEADING|TRAILING|BOTH [trim_char] FROM trim_source )
SELECT TRIM(BOTH '1' FROM '123TECH111') FROM DUAL;
 --23TECH
SELECT TRIM(LEADING '0' FROM '00012300') FROM DUAL; 
SELECT TRIM(TRAILING '1' FROM '11Tech11') FROM DUAL; 

--������ �Լ� : N�� INPUT - > FUNCTION - > N�� OUTPUT
--�׷� �Լ� : N�� INPUT - > FUNCTION - > 1���� �׷�, (N���� �ƴ� ����� ������ �׷� �Լ�)
--�Լ��� SELECT, WHERE ���� �����ϴ�

--SUBSTR : �÷�/���ڿ����� ������ ��ġ���� ������ ���� ��ŭ�� ���ڿ��� �߶󳻾� ��ȯ�ϴ� �Լ�
--STRING, POSITION, LENGTH(��ȯ ����)
SELECT SUBSTR('THIS IS A TEST', 6, 2) 
FROM DUAL;
-- ��� : IS 

SELECT SUBSTR('THIS IS A TEST', 6) 
FROM DUAL;
-- ��� : IS A TEST

SELECT SUBSTR('TECHONTHENET', -3, 3) 
FROM DUAL;
-- ��� : NET

SELECT SUBSTR('THIS IS A TEST', -6, 3) 
FROM DUAL;
-- ��� :A T

--(2) ���� �Լ�

-- ROUND �Լ� : ������ �ڸ������� �ݿø� �ϴ� �Լ�, �Ҽ����� �߿��ϱ� ������ ����� ��õ���� �ʴ� �Լ�
-- ROUND(number, [deciaml_places}) -> number 
SELECT ROUND(125.315) FROM DUAL;
--��� ��� : 125

SELECT ROUND(125.315, 0) FROM DUAL;
--��� ��� : 125

SELECT ROUND(125.315, 1) FROM DUAL;
--��� ��� : 125.3

SELECT ROUND(125.315, -1) FROM DUAL;
--��� ��� : 130

SELECT ROUND(-125.315, 2) FROM DUAL;
--��� ��� : -125.32

--TRUNC �Լ� : ������ �ڸ������� ������ �ϴ� �Լ�.
SELECT TRUNC(125.315) FROM DUAL;
--��� ��� : 125

SELECT TRUNC(125.315, 0) FROM DUAL;
--��� ��� : 125

SELECT TRUNC(125.315, 1) FROM DUAL;
--��� ��� : 125.3

SELECT TRUNC(125.315, -1) FROM DUAL;
--��� ��� : 120

SELECT TRUNC(-125.315, 2) FROM DUAL;
--��� ��� : -125.31

--(3) ��¥ �Լ�
-- SYSDATE : ��ȯ Ÿ�� DATE Ÿ���̴�. 
SELECT SYSDATE
FROM DUAL;

-- ADD_MONTHS : DATE TYPE, ���� ->DATE TYPE
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;
--��� : 20���� ������ ��

--MONTHS_BETWEEN : �� ��¥ ������ �������� ��ȯ, �ڿ��ִ� ���ڰ� ũ�� ������ ������ �ȴ�.-> NUMBER Ÿ�� ��ȯ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 AS �ٹ����
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >120;
-- MONTH �̴ϱ� ����� �ٲٱ� ���ؼ� 12�� ����

-- (4) Ÿ�Ժ�ȯ �Լ� : TO_DATE, TO_CHAR

--������ Ÿ���� ��ȯ�ϴ� �ΰ��� ����� ����, �Ͻ��� ��ȯ, ����� ��ȯ
-- NUMBER -- CHARACTER -- DATE (NUMBER ���� DATE �� CHARACTER�� ���ؼ� ��ȯ�Ǿ����)
-- TO_CHAR : NUMBER / DATE Ÿ���� CHARARCTER Ÿ������ ��ȯ�ϴ� �Լ�
-- TO_CHAR : '9'�� �ڸ��� ����, '0':���j �ڸ��� 0���� ǥ��, '$ �Ǵ� L' : ��ȭ��ȣ ǥ��, '. �Ǵ� , ':������ ��ġ�� . �Ǵ� , ǥ��
SELECT TO_CHAR(1234, '99999') FROM DUAL;
-- 1234
SELECT TO_CHAR(1234, '09999') FROM DUAL;
--01234
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
--��1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL;
--1,234
SELECT TO_CHAR(1234, '09,999') FROM DUAL;
--01,234
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL;
--  1.0E+03
SELECT TO_CHAR(1234, '999') FROM DUAL;
--####

--TO_CHAR (��¥ | ����, ǥ�� ����) -> ���ڿ�
SELECT SYSDATE, TO_CHAR(SYSDATE, 'PM YYYY- MM-DD HH:MI:SS')
FROM DUAL;

--�б� ���
SELECT SYSDATE, TO_CHAR(SYSDATE, 'Q')
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"'), 
SUBSTR(HIRE_DATE,1,2)||'��'|| SUBSTR(HIRE_DATE,4,2)||'��'|| SUBSTR(HIRE_DATE,7,2)||'��' AS �Ի��� 
FROM EMPLOYEE;

-- TO_DATE :
-- �Է�(���ڿ� ����!, ���ڿ��ε� ���ڿ����� - ���� �͵� ���� �ȵ�) -> ������δ� �Է°� �Ȱ��� ��� ������ ��������
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
--10/01/01

SELECT TO_CHAR( TO_DATE('20100101', 'YYYYMMDD'),'YYYY, MON') FROM DUAL;
--2010, 1�� 

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
--04/10/30

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'DD-MON-YY HH:MI:SS PM') FROM DUAL;
--30-10��-04 02:30:00 ����
-- ���� ���ڸ� DATE�� �ٲٰ� ���ϴ� �������� �ٲٱ� ���ؼ� CHAR�� �ٲ��ش�. 

SELECT HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = TO_DATE('900401 133030', 'YYMMDD HH24MISS');
-- ���� �ú��ʰ� �� �ִ� �������̸� HIRE_DATE = '900401'���� ���ϸ� �񱳰� �ȵȴ�. 
-- TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401' �ٵ� ���������� ��õ���� ����
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401';
--YYYY-RR

--TO_NUMBER : CHAR -> NUMBER TYPE���� 
SELECT EMP_NAME, EMP_NO,
    SUBSTR(EMP_NO,1,6)AS �պκ�,
    SUBSTR(EMP_NO,8) AS �޺κ�,
    TO_NUMBER( SUBSTR(EMP_NO,1,6) ) + TO_NUMBER( SUBSTR(EMP_NO,8) ) AS ���
FROM EMPLOYEE
WHERE EMP_ID = '101';

--(5) ��Ÿ �Լ�
-- NVL : NULL�� ������ ������ ��ȯ�ϴ� �Լ�, NVL(NULL�� ������ �� ���� ��ȯ, NULL�̸� �� ���� ��ȯ), 
SELECT EMP_NAME, SALARY , NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME, (SALARY *12)+((SALARY *12)*BONUS_PCT)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME, (SALARY *12)+((SALARY *12)*NVL(BONUS_PCT,0))
FROM EMPLOYEE
WHERE SALARY > 3500000;

--DECODE : SELECT �������� IF-ELSE ���� ���������� ������ ����Ŭ DMBS�Լ�
--DECODE(���, �񱳰�, TRUE�� ��� RESULT��, FALSE�� ��� RESULT ��])
SELECT EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1),'1','����', '3', '����', '����' ) AS GENDER
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, DECODE(MGR_ID, NULL, '������', MGR_ID) AS MANAGER, NVL(MGR_ID, '������') AS OTHERSCASE
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

--������ ���޺� �λ�޿��� Ȯ���ϰ� �ʹ�
-- J7 -> 20%, J6->15%, J5->10%
SELECT JOB_ID, EMP_NAME, SALARY, DECODE(JOB_ID, 'J7', SALARY*1.2,'J6', SALARY*1.15,'J5', SALARY*1.1, SALARY) AS "�λ� �޿�"
FROM EMPLOYEE;

-- CASE : DECODE �Լ��� ������ ANSI ǥ�� ����
-- CASE WHEN���� ���ǽĵ� ���� �� �־ ȿ�����̴�
SELECT JOB_ID, EMP_NAME, SALARY, CASE JOB_ID WHEN 'J7' THEN SALARY*1.2 WHEN 'J6'THEN SALARY*1.15 WHEN 'J5'THEN SALARY*1.1 ELSE SALARY END AS "�λ� �޿�"
FROM EMPLOYEE;

-- �׷��Լ�
-- SUM, AVG, // �Է� NUMBER��,  MIN, MAX, COUNT // ANY�� �Է��� ���� �� �ִ�.
-- NULL ���� ���� ó���� Ȯ���� �ؾ���. 
-- �׷��Լ��� SELECT ���� ���Ǹ� �ٸ� �÷� ���Ǵ� �Ұ�
 
SELECT SUM(SALARY), EMP_NAME
FROM EMPLOYEE;
 
SELECT *
FROM EMPLOYEE;
--ORDER BY
-- ORDER BY [���� �÷�] [ASC|DESC]
-- �μ���ȣ 50�̰ų� �μ���ȣ�� �������� �۴� ����� �̸�, �޿��� ��ȸ�϶�
 SELECT SALARY, EMP_NAME
 FROM EMPLOYEE
 WHERE DEPT_ID ='50' OR DEPT_ID IS NULL
 ORDER BY SALARY DESC;

 SELECT DEPT_ID, EMP_NAME, HIRE_DATE
 FROM EMPLOYEE
 WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
 ORDER BY DEPT_ID DESC NULLS LAST, HIRE_DATE ASC, EMP_NAME;

--�μ��� ��� �޿�
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS �޿����
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY �޿���� DESC;

--������ ���� �޿� ����� ���Ѵٸ�
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS �޿����
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY �޿���� DESC;

-- GROUP BY �� �ε��� ��Ī ������ �ȵȴ�.
-- ORDER BY [���� �÷� | �÷��ε��� | ��Ī] 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '2', '����','4','����', '����'), AVG(SALARY)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '2', '����','4','����', '����')
ORDER BY 2 DESC;
-- 2 �� �ǹ̴� �ι��� �÷��� �������� �ϰڴٴ� �ǹ�

SELECT CASE SUBSTR(EMP_NO, 8,1) WHEN '1' THEN '����' WHEN '3' THEN ���� ELSE '����' END , AVG(SALARY)
FROM EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO, 8,1) WHEN '1' THEN '����' WHEN '3' THEN ���� ELSE '����' END
ORDER BY 2 DESC;

--WHERE ������ �׷��Լ��� �� �� ����, ��ü ���̺� ���� ������ WHERE 
--HAVING �� �׷쿡 ���� ���� 
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS �޿����
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING AVG(SALARY) > 3000000
ORDER BY �޿���� DESC;

-- �߰� �߰� �Ұ踦 Ȯ���� �� �ִ�.
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS �޿����,JOB_ID
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY �޿���� DESC;

