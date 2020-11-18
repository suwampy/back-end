-- 010 비교 연산자 배우기 ①(>,<,>=,<=,=,!=,<>,^=)
-- 월급이 1200 이하인 사원들의 이름과 월급, 직업, 부서 번호 출력
SELECT ename, sal, job, deptno
  FROM emp
  WHERE sal <= 1200;
  
  
  
-- 011 비교 연산자 배우기 ②
-- 두 값 사이의 값들을 검색하는 방법
-- 월급이 1000에서 3000 사이인 사원들의 이름과 월급 출력
SELECT ename, sal
  FROM emp
  WHERE sal BETWEEN 1000 AND 3000;
-- BETWEEN 하한값 AND 상한값으로 작성해야 함
-- BETWEEN 상한값 AND 하한값으로 작성하면 조회 안됨!

SELECT ename, sal
  FROM emp
  WHERE (sal>= 1000 AND sal <= 3000);
  
-- 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급 조회
SELECT ename, sal
  FROM emp
  WHERE sal NOT BETWEEN 1000 AND 3000;

SELECT ename, sal
  FROM emp
  WHERE (sal < 1000 OR sal > 3000);

-- 1982년도에 입사한 사원들의 이름과 입사일을 조회
SELECT ename, hiredate
  FROM emp
  WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';
  
-- 012 비교 연산자 배우기 ③ (LIKE)
-- like 연산자를 이요하여 문자 패턴이 일치하는 형을 검색

-- 첫 글자가 S로 시작하는 사원들의 이름과 월급을 출력
SELECT ename, sal
  FROM emp
  WHERE ename LIKE 'S%';
  
-- %는 와일드 카드라고 함. 와일드카드는 이 자리에 어떠한 철자가 와도 상관 없고
-- 철자의 개수가 몇 개가 되든 상관 없다는 뜻
-- 'S%' = 첫 번째 철자가 S이고 두 번째 철자가 %인 데이터를 검색하겠다는 것
-- %가 특수문자 퍼센트가 아니라 와일드 카드가 되려면 이퀄 연산자(=)가 아닌 LIKE 연산자를 사용해야 함

-- 두 번째 철자가 M인 사원의 이름을 출력
SELECT ename
  FROM emp
  WHERE ename LIKE '_M%';
  
-- LIKE와 같이 쓰이는 기호는 와일드 카드(%)와 언더바(_)가 있음
-- 와일드 카드(%)는 와일드 카드가 있는 자리에 어떠한 철자가 와도 관계없고
-- 그 철자의 개수가 몇 개이든 관계없다는 것 (0개 이상의 임의 문자와 일치)
-- 언더바(_)는 어떠한 철자가 와도 관계 없으나 자리수는 한 자리여야 된다는 의미 (하나의 문자와 일치)

-- 이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력
SELECT ename
  FROM emp
  WHERE ename LIKE '%T';

-- 이름에 A를 포함하고 있는 사원들의 이름응ㄹ 출력
SELECT ename
  FROM emp
  WHERE ename LIKE '%A%';

-- 013 비교 연산자 배우기 ④ (IS NULL)
SELECT ename, comm
  FROM emp
  WHERE comm is null;
-- NULL 값은 데이터가 할당되지 않은 상태라고도 하고 알 수 없는 값이라고도 함
-- 알 수 없는 값이기 때문에 이퀄 연산자(=)로는 비교 불가
-- NULL 값을 검색하기 위해서는 is null 연산자를 사용해야 함

-- 014 비교 연산자 배우기 ⑤ (IN)
-- 여러 개의 리스트 값을 조회할 때는 in 연산자를 사용

-- 직업이 SALESMAN, ANALYST, MANAGER인 사원들의 이름, 월급, 직업을 출력
SELECT ename, sal, job
  FROM emp
  WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER');
  -- 이퀄 연산자는 하나의 값만 조회할 수 있는 반면 IN 연산자는 여러 리스트의 값을 조회할 수 있음
SELECT ename, sal, job
  FROM emp
  WHERE (job = 'SALESMAN' or job='ANALYST' or job='MANAGER');
  
-- 직업이 SALESMAN, ANALYST, MANAGER이 아닌 사원들의 이름, 월급, 직업을 출력
SELECT ename, sal, job
  FROM emp
  WHERE job NOT in ('SALESMAN', 'ANALYST', 'MANAGER');

SELECT ename, sal, job
  FROM emp
  WHERE (job != 'SALESMAN' or job != 'ANALYST' or job != 'MANAGER');
  
-- 015 논리 연산자 배우기 (AND, OR, NOT)
-- WHERE절에 여러 개의 조건을 AND 또는 OR을 이용하여 결합
-- 직업이 SALESMAN이고 월급이 1200 이상인 사원들의 이름, 월급, 직업 출력
SELECT ename, sal, job
  FROM emp
  WHERE job='SALESMAN' AND sal >= 1200;
  
-- 016 대소문자 변환 함수 (UPPER, LOWER, INITCAP)
-- 첫 번째 컬럼은 이름을 대문자로 출력하고
-- 두 번째 컬럼은 이름을 소문자로 출력하고
-- 세 번째 컬럼은 이름의 첫 번째 철자는 대문자로 하고 나머지는 소문자로 출력
SELECT UPPER(ename), LOWER(ename), INITCAP(ename)
  FROM emp;

-- upper : 대문자로 출력
-- lower : 소문자로 출력
-- initcap : 첫 번째 철자만 대문자로 출력하고 나머지는 소문자로 출력

-- upper 함수와 lower 함수는 테이블 내 특정 문자 데이터를 검색하고자 할 때
-- 데이터가 대문자인지 소문자로 저장되어 있는지 확실하지 않을 때
-- 정확한 데이터 검색을 위해 필요

-- 이름이 scott인 사원의 이름고 ㅏ월급 조회
SELECT ENAME, SAL
  FROM emp
  WHERE LOWER(ename) = 'scott';
  
-- 017 문자에서 특정 철자 추출 (SUBSTR)
-- 문자에서 특정 길이의 문자를 추출

-- SMITH에서 SMI만 잘라서 출력
SELECT SUBSTR('SMITH', 1, 3)
  FROM DUAL;

-- SUBSTR함수 : 문자에서 특정 위치의 문자열을 추출

-- 018 문자열의 길이를 출력하기 (LENGTH)
SELECT ename, LENGTH(ename)
  FROM emp;
  
-- 019 문자에서 특정 철자의 위치 출력하기(INSTR)
SELECT INSTR('SMITH', 'M')
  FROM DUAL;
  
-- 020 특정 철자를 다른 철자로 변경하기(REPLACE)
-- 이름과 월급을 출력하는데, 월급을 출력할 때 숫자 0을 *(별표)로 출력
SELECT ename, REPLACE(sal, 0, '*')
  FROM emp;
-- REPLACE 함수 : 특정 철자를 다른 철자로 변경하는 문자 함수

-- 월급의 숫자 0~3 까지를 *로 출력
SELECT ename, REGEXP_REPLACE(sal,'[0-3]', '*') as SALARY
  FROM emp;
  -- REGEXP_REPLACE : 정규식 함수
