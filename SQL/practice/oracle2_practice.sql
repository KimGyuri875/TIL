--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가 표시.)

SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO ='002'
ORDER BY ENTRANCE_DATE;

--2.교수 중 이름이 세 글자가 아닌 교수가 1 명 있다고 다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--?3. 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력.
SELECT SYSDATE
FROM DUAL

SELECT PROFESSOR_NAME AS 교수이름, TRUNC( MONTHS_BETWEEN( TRUNC(SYSDATE), TO_DATE( SUBSTR(PROFESSOR_SSN, 0,2), 'RR')) / 12) AS 나이
FROM TB_PROFESSOR
ORDER BY 나이;
--SELECT PROFESSOR_NAME AS 교수이름, TO_CHAR(SUBSTR(PROFESSOR_SSN, 0,6), 'YYYY"년" MM"월" DD"일"') AS 나이

-- 4. 교수들의 이름 중 성을 제외한이름만 출력하는 SQL 문장을 작성
SELECT SUBSTR(PROFESSOR_NAME, 2) AS 이름
FROM TB_PROFESSOR;

-- ?5. 재수생 입학자를 구하려고 다. 19살에 입학하면 재수를 하지 않은 것으로 간주.
-- 입학 나이 
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE, TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1,6), 'RRMMDD'), 'YY')
FROM TB_STUDENT;

-- 6.2020 년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE('20150816','YYYYMMDD'), 'day') 
FROM dual

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇월 몇 일을 의미까? 
--또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미까

SELECT  TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY"년" MM"월" DD"일"'), TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY"년" MM"월" DD"일"')
FROM dual;

SELECT  TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YYYY"년" MM"월" DD"일"'), TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'YYYY"년" MM"월" DD"일"')
FROM dual;

--8. 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 
SELECT ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10.학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 ℉榕 결과값이 출력
SELECT DEPARTMENT_NO AS 학과번호, COUNT(DEPARTMENT_NO) AS "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 학과번호;

--11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도, ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)

--?13. 학과 별 휴학생 수를 파악하고자 다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을

SELECT DEPARTMENT_NO, NVL(COUNT(*),0)
FROM TB_STUDENT 
WHERE ABSENCE_YN  = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--14. 동명이인(同名異人) 학생들의 이름을 찾고자 다. 어떤 SQL

SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*)>1;

--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총평점을 구하는 SQL 문을 작성하시오. 
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도, SUBSTR(TERM_NO, 5, 2) AS 학기, ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4),SUBSTR(TERM_NO, 5, 2))
ORDER BY 년도

