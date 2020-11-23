-- 031 날짜형으로 데이터 유형 변환하기
-- 문자를 날짜형으로 출력할 때는 TO_DATE 함수 사용
-- 81년 11월 17일에 입사한 사원의 이름과 입사일 출력
SELECT ename, hiredate
  FROM emp
  WHERE hiredate = TO_DATE('81/11/17', 'RR/MM/DD');

-- 032 암시적 형 변환 이해하기
-- 문자형 데이터를 숫자형 데이터로 암시적으로 형 변환 함
SELECT ename, sal
  FROM emp
  WHERE sal = '3000';
  -- sal은 숫자형 데이터 컬럼인데 문자형과 비교하고 있음
  -- 오라클은 문자형 숫자형 두 개를 비교할 때는 문자형을 숫자형으로 변환함
  
-- 문자형과 문자형 비교
SELECT ename, sal
  FROM emp32
  WHERE sal = '3000';
  -- 정상 출력
  
-- 숫자형으로 비교해서 검색  
SELECT ename, sal
  FROM emp32
  WHERE sal =3000;
  -- 정상출력
  -- 오라클이 내부적으로 숫자형=숫자형으로 비교해서 데이터 검색
-- 오라클은 다음과 같은 쿼리로 변환해서 실행함
SELECT ename, sal
  FROM emp32
  WHERE TO_NUMBER(SAL) = 3000;
  
-- 033 NULL 값 대신 다른 데이터 출력하기 (NVL, NVL2)
-- 이름과 커미션을 출력하는데 커미션이 NULL인 사원들은 0ㅇ으로 출력
SELECT ename, comm, NVL(comm,0)
  FROM emp;
  
-- 이름, 월급, 커미션, 월급 + 커미션을 출력
SELECT ename, sal, comm, sal+comm
  FROM emp
  WHERE job IN ('SALESMAN', 'ANALYST');
  
-- 커미션 NULL을 0으로 치환하여 월급+커미션을 출력
SELECT ename, sal, comm, NVL(comm,0), sal+NVL(comm,0)
  FROM emp
  WHERE job IN ('SALESMAN', 'ANALYST');
  
-- 커미션이 NULL이 아닌 사원들은 sal+comm을 출력하고 
-- NULL인 사원들은 sal을 출력하는 예제
SELECT ename, sal, comm, NVL2(comm, sal+comm, sal)
  FROM emp
  WHERE job IN ('SALESMAN','ANALYST');
  
-- 034 IF문을 SQL로 구현(DECODE)
-- 부서번호가 10이면 300, 20이면 400, 10도 20도 아니면 0
SELECT ename, deptno, DECODE(deptno,10,300,20,400,0) as 보너스
  FROM emp;
  
-- 사원 번호와 사원 번호가 짝수인지 홀수 인지를 출력하는 쿼리
SELECT empno, mod(empno,2), DECODE(mod(empno,2),0,'짝수',1,'홀수') as 보너스
  FROM emp;
  
-- 이름과 직업과 보너스를 출력하는데
-- 직업이 SALESMAN이면 보너스 5000을 출력하고
-- 나머지 직업은 보너스 2000을 출력
SELECT ename, job, DECODE(job, 'SALESMAN', 5000, 2000) as 보너스
  FROM emp;
  
-- 035 IF문을 SQL로 구현하기 ② (CASE)
-- 이름, 직업, 월급, 보너스를 출력
-- 보너스는 월급이 3000 이상이면 500을 출력
--         월급이 2000 이상이고 3000보다 작으면 300을 출력
--         월급이 1000 이상이고 2000보다 작으면 200을 출력
-- 나머지 사원들은 0을 출력
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

-- DECODE는 등호(=) 비교만 가능하지만 CASE는 등호(=) 비교와
-- 부등호(>=, <=, >, <) 둘 다 가능

-- 이름, 직업, 커미션, 보너스 출력
-- 보너스는 커미션이 NULL이면 500을 출력, NULL이 아니면 0을 출력
SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                        ELSE 0 END BONUS
FROM emp
WHERE job IN ('SALESMAN', 'ANALYST');

-- 보너스를 출력할 때 직업이 SALESMAN, ANALYST이면 500 출력,
-- 직업이 CLERK, MANAGER이면 400을 출력, 나머지 직업은 0을 출력
SELECT ename, job, CASE WHEN job in ('SALESMAN', 'ANALYST') THEN 500
                   WHEN job in ('CLERK', 'MANAGER') THEN 400
                   ELSE 0 END as 보너스
FROM emp;

-- 036 최대값 출력하기 (MAX)
-- 직업이 SALESMAN인 사원들 중 최대 월급을 출력
SELECT MAX(sal)
  FROM emp
  WHERE job = 'SALESMAN';
  
-- 직업이 SALESMAN인 사원들 중 최대 월급을 직업과 같이 출력하기 위해
-- JOB 컬럼 추가
SELECT job, MAX(sal)
  FROM emp
  WHERE job = 'SALESMAN';
  -- 오류 발생
  -- job 컬럼의 값은 여러개의 행이 출력..
  -- MAX(SAL) 값은 하나가 출력되려 하기 때문
  -- => GROUP BY 절 필요 : 데이터를 GROUOPING
SELECT job, MAX(sal)
  FROM emp
  WHERE job = 'SALESMAN'
  GROUP BY job;

-- 부서 번호와 부서 번호별 최대 월급 출력
SELECT deptno, MAX(sal)
  FROM emp
  GROUP BY deptno;
  
-- 037 최소값 출력하기 (MIN)
-- 직업이 SALESMAN인 사원들 중 최소 월급을 출력
SELECT MIN(sal)
  FROM emp
  WHERE job = 'SALESMAN';
  
-- 직업과 직업별 최소 월급 출력,
-- 최소 월급이 높은 것부터 출력
SELECT job, MIN(sal) 최소값
  FROM emp
  GROUP BY job
  ORDER BY 최소값 DESC;
  -- ORDER BY절은 항상 맨 마지막에 작성하고 실행 또한 맨 마지막에 실행됨
-- 그룹함수 : WHERE절의 조건이 거짓이어도 결과를 항상 출력
-- 직업, 직업별 최소 월급 출력하는데
-- 직업에서 SALESMAN은 제외하고 출력하고 직업별 최소 월급이 높은 것부터 출력하는 쿼리
SELECT job, MIN(sal)
  FROM emp
  WHERE job != 'SALESMAN'
  GROUP BY job
  ORDER BY MIN(sal) DESC;
  
-- 038 평균값 출력하기(AVG)
SELECT AVG(comm)
  FROM emp;
  
-- 039 토탈값 출력하기(SUM)
-- 부서 번호와 부서 번호별 토탈 월급 출력
SELECT deptno, SUM(sal)
 FROM emp
 GROUP by deptno;
 
SELECT job, SUM(sal)
  FROM emp
  GROUP BY job
  ORDER BY sum(sal) DESC;
  
-- 직업과 직업별 토탈 월급을 출력하는데, 직업별 토탈 월급이 4000 이상인 것만 출력
SELECT job, SUM(sal)
  FROM emp
  WHERE sum(sal) >= 4000
  GROUP BY job;
  -- 오류 발생
  --그룹 함수로 조건을 줄 떄는 WHERE 절 대신 HAVING 절 사용
SELECT job, SUM(sal)
  FROM emp
  GROUP BY job
  HAVING sum(sal) >=4000;
  
-- 직업과 직업별 토탈 월급을 출력하는데
-- 직업에서 SALESMAN은 제외하고
-- 직업별 토탈 월급이 4000 이상인 사원들만 출력
SELECT job, SUM(sal)
  FROM emp
  WHERE job !='SALESMAN'
  GROUP BY job
  HAVING sum(sal) >= 4000;
  
-- 040 건수 출력하기 (COUNT)
SELECT COUNT(empno)
  FROM emp;
