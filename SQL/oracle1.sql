--COMMENT
SELECT *
FROM EMPLOYEE;

SELECT [특정컬럼] | *(전체컬럼)| 표현식 | DISTINCT | AS 컬럼별칭
FROM 테이블 이름:
WHERE 조건식(행의 제한)

--전체컬럼 
SELECT *
FROM EMPLOYEE;

--특정 컬럼
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE;

--별칭
--주의사항 : 반드시 문자로 시작(숫자로 시작할 수 없다.), 만약 특수 부호가 들어가면 ""으로 감싼다
--AS 생략가능
SELECT EMP_NAME AS "이  름", EMP_NO AS 주민번호, SALARY AS "급여(원)", DEPT_ID 부서번호
FROM EMPLOYEE;

--DISTINCT : 값의 중복을 제거할 때 사용하는 키워드
SELECT DISTINCT JOB_ID
FROM EMPLOYEE;

--표현식
--컬럼 값에 대한 연산을 식으로 작성할 수 있다.
SELECT EMP_NAME AS 사원명, SALARY AS 급여, (SALARY + (SALARY * BONUS_PCT)) * 12 AS 연봉
FROM EMPLOYEE;

--더미컬럼, 컬럼을 추가할 수 있다. 
--'' : 데이터를 의미한다.
--"" : 키워드로 취급
SELECT EMP_ID, EMP_NAME, '재직' AS 근무여부
FROM EMPLOYEE;
-- 실행 결과로 근무여부 칼럼이 생기고 안에 데이터는 '재직'으로 채워진다.

--행에 대한 제한을 두기 
--WHERE : 행의 제한
--조건절에서 연산자를 사용할 수 있다
--부서번호가 90번인 사원들의 정보만 확인하고 싶다면 
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 90;

--EX
--부서코드가 90이고 급여가 2000000보다 많이 받는 사월의 이름, 부서코드, 급여를 조회
--AND
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY > 2000000 AND DEPT_ID = 90;

--EX)
--부서코드가 90이거나 20번인 사원의 이름, 부서코드 급여를 조회
--OR
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE (DEPT_ID = 90 OR DEPT_ID = 20);

-- || : 연결연산자
-- [컬럼||컬럼] [컬럼||'문자열']
SELECT EMP_ID||EMP_NAME||SALARY
FROM EMPLOYEE

SELECT EMP_ID||'의 월급은 '||SALARY||'입니다'
FROM EMPLOYEE

--Operator 
-- 비교 연산자 - BETWEEN AND : 비교하려는 값이 지정한 범위(상한 값과 하한 값의 경계포함)에 포함되면 TRUE를 반환하는 연산자
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 5500000;
-- 또는
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 5500000;

--비교 연산자 - LIKE : 비교하려는 값이 지정한 특정 패턴을 만족시키면 TRUE를 반환
--패턴 지정을 위해 와일드 카드 사용
-- % : %에 임의 문자열(0개 이상의 문자)이 있다는 의미
-- _ : _부분에 문자 1개만 있다는 의미, '_'사이에는 공백이 없음
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9_______'

--EX)
-- EMAIL ID 중 '_'앞 자리가 3자리인 직원의 이름, 이메일을 조회
-- ESCAPE을 통해서 와일드 카드가 아님을 나타냄
SELECT EMP_NAME, EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- NOT LIKE
--'김'씨 성이 아닌 직원의 이름과 급여를 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

-- 부서가 없는데도 불구하고 보너스를 지급받는 직원의 이름, 부서, 보너스를 조회
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID = NULL AND BONUS_PCT != NULL
-- 하면 안된다!
--NULL은 비교 연산자가 안된다
-- IS NULL, IS NOT NULL
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL

-- IN=OR
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN('90', '20');

-- 부서 번호가 20번 또는 90번인 사원 중 급여가 3000000 많이(초과)받는 직원의 이름, 급여, 부서코드를 조회
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN('90', '20') AND SALARY > 3000000;

