--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ��.)

SELECT STUDENT_NO AS �й�, STUDENT_NAME AS �̸�, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS ���г⵵
FROM TB_STUDENT
WHERE DEPARTMENT_NO ='002'
ORDER BY ENTRANCE_DATE;

--2.���� �� �̸��� �� ���ڰ� �ƴ� ������ 1 �� �ִٰ� ����. �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����.������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--?3. ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ���.
SELECT SYSDATE
FROM DUAL

SELECT PROFESSOR_NAME AS �����̸�, TRUNC( MONTHS_BETWEEN( TRUNC(SYSDATE), TO_DATE( SUBSTR(PROFESSOR_SSN, 0,2), 'RR')) / 12) AS ����
FROM TB_PROFESSOR
ORDER BY ����;
--SELECT PROFESSOR_NAME AS �����̸�, TO_CHAR(SUBSTR(PROFESSOR_SSN, 0,6), 'YYYY"��" MM"��" DD"��"') AS ����

-- 4. �������� �̸� �� ���� �������̸��� ����ϴ� SQL ������ �ۼ�
SELECT SUBSTR(PROFESSOR_NAME, 2) AS �̸�
FROM TB_PROFESSOR;

-- ?5. ����� �����ڸ� ���Ϸ��� ����. 19�쿡 �����ϸ� ����� ���� ���� ������ ����.
-- ���� ���� 
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE, TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1,6), 'RRMMDD'), 'YY')
FROM TB_STUDENT;

-- 6.2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE('20150816','YYYYMMDD'), 'day') 
FROM dual

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��� �� ���� �ǹ�����? 
--�� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����

SELECT  TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY"��" MM"��" DD"��"'), TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY"��" MM"��" DD"��"')
FROM dual;

SELECT  TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YYYY"��" MM"��" DD"��"'), TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'YYYY"��" MM"��" DD"��"')
FROM dual;

--8. 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
SELECT ROUND(AVG(POINT),1) AS ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10.�а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ���
SELECT DEPARTMENT_NO AS �а���ȣ, COUNT(DEPARTMENT_NO) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY �а���ȣ;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ��
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
SELECT SUBSTR(TERM_NO, 1, 4) AS �⵵, ROUND(AVG(POINT),1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)

--?13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������

SELECT DEPARTMENT_NO, NVL(COUNT(*),0)
FROM TB_STUDENT 
WHERE ABSENCE_YN  = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--14. ��������(��٣���) �л����� �̸��� ã���� ����. � SQL

SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*)>1;

--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , �������� ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
SELECT SUBSTR(TERM_NO, 1, 4) AS �⵵, SUBSTR(TERM_NO, 5, 2) AS �б�, ROUND(AVG(POINT),1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4),SUBSTR(TERM_NO, 5, 2))
ORDER BY �⵵

