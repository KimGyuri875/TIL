--1. 함수
--2. ORDER BY
--3. GROUP BY
--4. HAVING
SELECT [특정 컬럼 | * (전체컬럼) | 표현식 | DISTINCT | AS 컬럼별칭
FROM 테이블 이름
WHERE 조건식
GROUP BY 기준 컬럼
HAVING 조건식
ORDER BY 기준컬럼;
--ORBER BY 는 항상 마지막

--1. 함수: 문자열 함수, 숫자 함수, 날짜 함수, 타입변환 함수, 기타함수
--(1) 문자열 함수: LENGTH, LPAD/RPAD, INSTR, LTIRM/RTIRM/TRIM, SUBSTR

--LENGTH() : NUMBER이 반환타입, 문자열의 길이를 반환
SELECT CHARTYPE, LENGTH(CHARTYPE), VARCHARTYPE, LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;
-- CHAR(고정길이), VARCHAR2(가변길이), (주로 VARCHAR2를 사용한다)
-- CHAR TYPE : 실제 데이터 길이에 상관없이 컬럼 전체 길이를 반환
-- VARCHAR2 : 실제 데이터 길이 반환 

--INSTR() : 찾는 문자(열)이 지정한 위치부터 지정한 회수만큼 나타난 시작 위치를 반환하는 함수
-- INSTR(문자열, 찾으려는 문자, 시작 위치, 그중 몇번째로 발견되는)
SELECT EMAIL,
INSTR( EMAIL,'c',-1,2 ) 위치
FROM EMPLOYEE ;

SELECT EMAIL,
INSTR( EMAIL, 'c', INSTR( EMAIL,'.' )-1 ) 위치
FROM EMPLOYEE ;
-- '.'의 위치를 먼저 찾고 그 위치에서 한 자리수 앞.

--LPAD, RPAD(STRING, N ,[STR]) : 컬럼/문자열에 임의의 문자(열)을 왼쪽/오른쪽에 덧붙여 결과가 길이 N의 문자열을 반환
SELECT EMAIL AS 원본데이터,
 LENGTH(EMAIL) AS 원본길이,
 LPAD(EMAIL, 20, '.') AS 적용결과,
 LENGTH(LPAD(EMAIL, 20, '.')) AS 결과길이
FROM EMPLOYEE;

--LTIRM/RTRIM/TRIM : 컬럼/문자열읭 왼쪽/오른쪽에서 지정한 STR에 포함된 모든 문자를 제거한 나머지를 반환하는 함수
-- 패턴을 제거하는 의미가 아님
SELECT LTRIM('...TECH') FROM DUAL;
SELECT LTRIM('...TECH','.') FROM DUAL;
SELECT LTRIM('6748TECH', '0123456789') FROM DUAL;
SELECT LTRIM('1234TECH123', '1234') FROM DUAL;
--결과 : TECH123
SELECT TRIM('   TECH   ') FROM DUAL;
 --TRIM( LEADING|TRAILING|BOTH [trim_char] FROM trim_source )
SELECT TRIM(BOTH '1' FROM '123TECH111') FROM DUAL;
 --23TECH
SELECT TRIM(LEADING '0' FROM '00012300') FROM DUAL; 
SELECT TRIM(TRAILING '1' FROM '11Tech11') FROM DUAL; 

--단일행 함수 : N개 INPUT - > FUNCTION - > N개 OUTPUT
--그룹 함수 : N개 INPUT - > FUNCTION - > 1개의 그룹, (N개가 아닌 결과가 나오면 그룹 함수)
--함수는 SELECT, WHERE 적용 가능하다

--SUBSTR : 컬럼/문자열에서 지정한 위치부터 지정한 개수 만큼의 문자열을 잘라내어 반환하는 함수
--STRING, POSITION, LENGTH(반환 개수)
SELECT SUBSTR('THIS IS A TEST', 6, 2) 
FROM DUAL;
-- 결과 : IS 

SELECT SUBSTR('THIS IS A TEST', 6) 
FROM DUAL;
-- 결과 : IS A TEST

SELECT SUBSTR('TECHONTHENET', -3, 3) 
FROM DUAL;
-- 결과 : NET

SELECT SUBSTR('THIS IS A TEST', -6, 3) 
FROM DUAL;
-- 결과 :A T

--(2) 숫자 함수

-- ROUND 함수 : 지정한 자릿수에서 반올림 하는 함수, 소수점도 중요하기 때문에 사요을 추천하지 않는 함수
-- ROUND(number, [deciaml_places}) -> number 
SELECT ROUND(125.315) FROM DUAL;
--출력 결과 : 125

SELECT ROUND(125.315, 0) FROM DUAL;
--출력 결과 : 125

SELECT ROUND(125.315, 1) FROM DUAL;
--출력 결과 : 125.3

SELECT ROUND(125.315, -1) FROM DUAL;
--출력 결과 : 130

SELECT ROUND(-125.315, 2) FROM DUAL;
--출력 결과 : -125.32

--TRUNC 함수 : 지정한 자릿수에서 버림을 하는 함수.
SELECT TRUNC(125.315) FROM DUAL;
--출력 결과 : 125

SELECT TRUNC(125.315, 0) FROM DUAL;
--출력 결과 : 125

SELECT TRUNC(125.315, 1) FROM DUAL;
--출력 결과 : 125.3

SELECT TRUNC(125.315, -1) FROM DUAL;
--출력 결과 : 120

SELECT TRUNC(-125.315, 2) FROM DUAL;
--출력 결과 : -125.31

--(3) 날짜 함수
-- SYSDATE : 반환 타입 DATE 타입이다. 
SELECT SYSDATE
FROM DUAL;

-- ADD_MONTHS : DATE TYPE, 월수 ->DATE TYPE
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;
--결과 : 20년이 더해진 값

--MONTHS_BETWEEN : 두 날짜 사이의 개월수를 반환, 뒤에있는 인자가 크면 음수로 리턴이 된다.-> NUMBER 타입 반환
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 AS 근무년수
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >120;
-- MONTH 이니깐 년수로 바꾸기 위해서 12로 나눔

-- (4) 타입변환 함수 : TO_DATE, TO_CHAR

--데이터 타입을 변환하는 두가지 방법을 제공, 암시적 변환, 명시적 변환
-- NUMBER -- CHARACTER -- DATE (NUMBER 에서 DATE 는 CHARACTER를 통해서 변환되어야함)
-- TO_CHAR : NUMBER / DATE 타입을 CHARARCTER 타입으로 변환하는 함수
-- TO_CHAR : '9'는 자리수 지정, '0':남즞 자리를 0으로 표시, '$ 또는 L' : 통화기호 표시, '. 또는 , ':지정한 위치에 . 또는 , 표시
SELECT TO_CHAR(1234, '99999') FROM DUAL;
-- 1234
SELECT TO_CHAR(1234, '09999') FROM DUAL;
--01234
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
--￦1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL;
--1,234
SELECT TO_CHAR(1234, '09,999') FROM DUAL;
--01,234
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL;
--  1.0E+03
SELECT TO_CHAR(1234, '999') FROM DUAL;
--####

--TO_CHAR (날짜 | 숫자, 표현 형식) -> 문자열
SELECT SYSDATE, TO_CHAR(SYSDATE, 'PM YYYY- MM-DD HH:MI:SS')
FROM DUAL;

--분기 출력
SELECT SYSDATE, TO_CHAR(SYSDATE, 'Q')
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"'), 
SUBSTR(HIRE_DATE,1,2)||'년'|| SUBSTR(HIRE_DATE,4,2)||'월'|| SUBSTR(HIRE_DATE,7,2)||'일' AS 입사일 
FROM EMPLOYEE;

-- TO_DATE :
-- 입력(문자열 정수!, 문자열인데 숫자여야함 - 같은 것도 들어가면 안됨) -> 출력으로는 입력과 똑같은 출력 형식을 가져야함
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
--10/01/01

SELECT TO_CHAR( TO_DATE('20100101', 'YYYYMMDD'),'YYYY, MON') FROM DUAL;
--2010, 1월 

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
--04/10/30

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'DD-MON-YY HH:MI:SS PM') FROM DUAL;
--30-10월-04 02:30:00 오후
-- 먼저 숫자를 DATE로 바꾸고 원하는 형식으로 바꾸기 위해서 CHAR로 바꿔준다. 

SELECT HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = TO_DATE('900401 133030', 'YYMMDD HH24MISS');
-- 만약 시분초가 들어가 있는 데이터이면 HIRE_DATE = '900401'으로 비교하면 비교가 안된다. 
-- TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401' 근데 성능적으로 추천하지 않음
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401';
--YYYY-RR

--TO_NUMBER : CHAR -> NUMBER TYPE으로 
SELECT EMP_NAME, EMP_NO,
    SUBSTR(EMP_NO,1,6)AS 앞부분,
    SUBSTR(EMP_NO,8) AS 뒷부분,
    TO_NUMBER( SUBSTR(EMP_NO,1,6) ) + TO_NUMBER( SUBSTR(EMP_NO,8) ) AS 결과
FROM EMPLOYEE
WHERE EMP_ID = '101';

--(5) 기타 함수
-- NVL : NULL을 지정한 값으로 변환하는 함수, NVL(NULL이 없으면 이 값을 반환, NULL이면 이 값을 반환), 
SELECT EMP_NAME, SALARY , NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME, (SALARY *12)+((SALARY *12)*BONUS_PCT)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME, (SALARY *12)+((SALARY *12)*NVL(BONUS_PCT,0))
FROM EMPLOYEE
WHERE SALARY > 3500000;

--DECODE : SELECT 구문에서 IF-ELSE 논리를 제한적으로 구현한 오라클 DMBS함수
--DECODE(대상, 비교값, TRUE일 경우 RESULT값, FALSE일 경우 RESULT 값])
SELECT EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1),'1','남자', '3', '남자', '여자' ) AS GENDER
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, DECODE(MGR_ID, NULL, '관리자', MGR_ID) AS MANAGER, NVL(MGR_ID, '관리자') AS OTHERSCASE
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

--직원의 직급별 인상급여를 확인하고 싶다
-- J7 -> 20%, J6->15%, J5->10%
SELECT JOB_ID, EMP_NAME, SALARY, DECODE(JOB_ID, 'J7', SALARY*1.2,'J6', SALARY*1.15,'J5', SALARY*1.1, SALARY) AS "인상 급여"
FROM EMPLOYEE;

-- CASE : DECODE 함수와 유사한 ANSI 표준 구문
-- CASE WHEN으로 조건식도 넣을 수 있어서 효율적이다
SELECT JOB_ID, EMP_NAME, SALARY, CASE JOB_ID WHEN 'J7' THEN SALARY*1.2 WHEN 'J6'THEN SALARY*1.15 WHEN 'J5'THEN SALARY*1.1 ELSE SALARY END AS "인상 급여"
FROM EMPLOYEE;

-- 그룹함수
-- SUM, AVG, // 입력 NUMBER형,  MIN, MAX, COUNT // ANY형 입력을 받을 수 있다.
-- NULL 값에 대한 처리를 확실히 해야함. 
-- 그룹함수가 SELECT 절에 사용되면 다른 컬럼 정의는 불가
 
SELECT SUM(SALARY), EMP_NAME
FROM EMPLOYEE;
 
SELECT *
FROM EMPLOYEE;
--ORDER BY
-- ORDER BY [기준 컬럼] [ASC|DESC]
-- 부서번호 50이거나 부서번호가 존재하지 앟는 사원의 이름, 급여를 조회하라
 SELECT SALARY, EMP_NAME
 FROM EMPLOYEE
 WHERE DEPT_ID ='50' OR DEPT_ID IS NULL
 ORDER BY SALARY DESC;

 SELECT DEPT_ID, EMP_NAME, HIRE_DATE
 FROM EMPLOYEE
 WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
 ORDER BY DEPT_ID DESC NULLS LAST, HIRE_DATE ASC, EMP_NAME;

--부서별 평균 급여
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS 급여평균
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 급여평균 DESC;

--성별에 따른 급여 평균을 구한다면
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS 급여평균
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 급여평균 DESC;

-- GROUP BY 는 인덱스 별칭 적용이 안된다.
-- ORDER BY [기준 컬럼 | 컬럼인덱스 | 별칭] 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '2', '여자','4','여자', '남자'), AVG(SALARY)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '2', '여자','4','여자', '남자')
ORDER BY 2 DESC;
-- 2 의 의미는 두번쨰 컬럼을 기준으로 하겠다는 의미

SELECT CASE SUBSTR(EMP_NO, 8,1) WHEN '1' THEN '남자' WHEN '3' THEN 남자 ELSE '여자' END , AVG(SALARY)
FROM EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO, 8,1) WHEN '1' THEN '남자' WHEN '3' THEN 남자 ELSE '여자' END
ORDER BY 2 DESC;

--WHERE 절에는 그룹함수를 쓸 수 없다, 전체 테이블에 대한 조건은 WHERE 
--HAVING 은 그룹에 대한 조건 
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS 급여평균
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING AVG(SALARY) > 3000000
ORDER BY 급여평균 DESC;

-- 중간 중간 소계를 확인할 수 있다.
SELECT DEPT_ID, ROUND( AVG(SALARY), -5) AS 급여평균,JOB_ID
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY 급여평균 DESC;

