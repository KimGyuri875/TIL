--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ��

SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS �ּ���
FROM TB_STUDENT
ORDER BY "�л� �̸�";

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3.�ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS �й�, STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '��⵵%' OR STUDENT_ADDRESS LIKE '������%') AND STUDENT_NO LIKE '9%'
ORDER BY �л��̸�;

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ����, (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ)
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS �й�, STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '��⵵%' OR STUDENT_ADDRESS LIKE '������%') AND STUDENT_NO LIKE '9%'
ORDER BY �л��̸�;

--5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. 
--������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ��
SELECT STUDENT_NO, ROUND(POINT, 2)
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO = '200402'
ORDER BY POINT DESC, STUDENT_NO;

--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL

SELECT STUDENT_NO,STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT,TB_DEPARTMENT
WHERE TB_DEPARTMENT.DEPARTMENT_NO = TB_STUDENT.DEPARTMENT_NO
ORDER BY STUDENT_NAME;

--7.���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS,TB_DEPARTMENT
WHERE TB_DEPARTMENT.DEPARTMENT_NO = TB_CLASS.DEPARTMENT_NO;

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ��
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS,TB_CLASS_PROFESSOR,TB_PROFESSOR
WHERE TB_CLASS.CLASS_NO = TB_CLASS_PROFESSOR.CLASS_NO  AND TB_PROFESSOR.PROFESSOR_NO = TB_CLASS_PROFESSOR.PROFESSOR_NO;

--9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL 
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS,TB_CLASS_PROFESSOR,TB_PROFESSOR,TB_DEPARTMENT
WHERE TB_CLASS.CLASS_NO = TB_CLASS_PROFESSOR.CLASS_NO  AND TB_PROFESSOR.PROFESSOR_NO = TB_CLASS_PROFESSOR.PROFESSOR_NO 
AND TB_PROFESSOR.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO AND CATEGORY='�ι���ȸ';

--10.�������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�",
--"�� ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ������.)

SELECT TB_STUDENT.STUDENT_NO AS �й�, TB_STUDENT.STUDENT_NAME AS "�л� �̸�", ROUND(AVG(POINT),1) AS "��ü ����"
FROM TB_GRADE,TB_STUDENT,TB_DEPARTMENT
WHERE TB_DEPARTMENT.DEPARTMENT_NO = TB_STUDENT.DEPARTMENT_NO AND DEPARTMENT_NAME='�����а�' AND TB_STUDENT.STUDENT_NO = TB_GRADE.STUDENT_NO
GROUP BY TB_STUDENT.STUDENT_NO,TB_STUDENT.STUDENT_NAME
ORDER BY TB_STUDENT.STUDENT_NO;

--11. �й��� A313047�� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�.

SELECT DEPARTMENT_NAME AS �а��̸�, STUDENT_NAME AS �л��̸�, PROFESSOR_NAME AS ���������̸� 
FROM TB_STUDENT, TB_DEPARTMENT,TB_PROFESSOR
WHERE TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO AND TB_STUDENT.COACH_PROFESSOR_NO=TB_PROFESSOR.PROFESSOR_NO
AND TB_STUDENT.STUDENT_NO = 'A313047';

--12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸦ ǥ���ϴ� SQL
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT,TB_GRADE,TB_CLASS
WHERE TB_STUDENT.STUDENT_NO = TB_GRADE.STUDENT_NO AND TB_CLASS.CLASS_NO=TB_GRADE.CLASS_NO
AND TERM_NO LIKE '2007%' AND CLASS_NAME = '�ΰ������';

--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� �����̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS LEFT OUTER JOIN TB_CLASS_PROFESSOR ON TB_CLASS_PROFESSOR.CLASS_NO = TB_CLASS.CLASS_NO
LEFT OUTER JOIN TB_DEPARTMENT ON TB_DEPARTMENT.DEPARTMENT_NO = TB_CLASS.DEPARTMENT_NO
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL ;





