
-- 041  데이터 분석 함수로 순위 출력하기 1(rank)
-- 직업이 analyst, manger 인 사원들의 이름, 직업, 월급, 월급의 순위 출력
SELECT ename, job, sal , RANK() over (ORDER BY sal DESC) 순위
   FROM emp
WHERE job in ('ANALSY', 'MANAGER');

-- RANK() 뒤에 OVER 다음에 괄호 안에 출력하고 싶은 데이터를 정렬하는 SQL문장을 넣으면
-- 그 컬럼 값에 대한 데이터의 순위가 출력됨


-- 직업별로 월급이 높은 순서대로 순위를 부여해서 각각 출력
SELECT ename, sal, job, RANK() over (PARTITION BY job 
                                     ORDER BY sal DESC) as 순위
FROM emp;

-- 042 데이터 분석 함수로 순위 출력하기 2 (DENSE_RANK)
-- 직업이 ANALYST, MANAGER인 사원들의 이름, 직업, 월급의 순의를 출력하는데
-- 순위 1위인 사원이 두 명이 있을 경우 다음 순위가 3위로 출력되지 않고 2위로 출력
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) AS RANK,
                        DENSE_RANK() over (ORDER BY sal DESC) AS DENSE_RANK
  FROM emp
  WHERE job in ('ANALYST', 'MANAGER');
  
-- 81년도에 입사한 사원들의 직업, 이름, 월급, 순위를 출력하는데, 
-- 직업별로 월급이 높은 순서대로 순위를 부여한 쿼리
SELECT job, ename, sal, DENSE_RANK() OVER (PARTITION BY job
                                           ORDER BY sal DESC) 순위
  FROM emp
  WHERE  hiredate BETWEEN to_date('1981/01/01', 'RRRR/MM/DD')
                      AND to_date('1981/12/31', 'RRRR/MM/DD');

-- 월급이 2975인 사원은 사원 테이블에서 월급의 순위가
-- 어떻게 되는지 출력
SELECT DENSE_RANK(2975) within group (ORDER BY sal DESC) 순위
  FROM emp;
  
-- 입사일 81년 11월 17일 사원 테이블 전체 사원들 중
-- 몇 번째로 입사한 것인지 출력
SELECT DENSE_RANK('81/11/17') within group (ORDER BY hiredate ASC) 순위
  FROM emp;
  
-- 043 데이터 분석 함수로 등급 출력하기 (NTITLE)
-- 월급의 등급은 4등급으로 나눠 출력
SELECT ename, job, sal,
       NTILE(4) over (order by sal desc nulls last) 등급
  FROM emp   
  WHERE job in ('ANALYST', 'MANAGER', 'CLERK');
  
-- 044 데이터 분석 함수로 순의위 비율 출력하기 (CUME_DIST)
-- 이름과 월급, 월급의 순위, 월급의 순위 비율 출력
SELECT ename, sal, RANK() over (order by sal desc) as RANK,
                   DENSE_RANK() over (order by sal desc) as DENSE_RANK,
                   CUME_DIST() over (order by sal desc) as CUM_DIIST
  FROM emp;

-- 직업별로 CUME_DIST 출력
SELECT job, ename, sal, RANK() over (partition by job order by sal desc) as RANK,
                        CUME_DIST() over (partition by job order by sal desc) as CUM_DIST
  FROM emp;

-- 045 데이터 분석 함수로 데이터를 가로로 출력(LISTAGG)
-- 부서 번호, 해당 부서에 속하는 사원들의 이름을 가로로 출력
SELECT deptno, LISTAGG(ename,',') within group (order by ename) as EMPLOYEE
  FROM emp
  GROUP BY deptno;
  
SELECT job, LISTAGG(ename,',') within group (ORDER BY ename asc) as employee
  FROM emp
  GROUP BY job;

-- 046 데이터 분석 함수로 바로 전 행과 다음 행 출력하기 (LAG, LEAD)
-- 사원 번호, 이름, 월급, 바로 전 행의 월급, 바로 다음 행의 월급
SELECT empno, ename, sal,
       LAG(sal,1) over (order by sal asc) "전 행",
       LEAD(sal,1) over (order by sal asc) "다음 행"
  FROM emp
  WHERE job in ('ANALYST', 'MANAGER');

-- ,직업이 ANALYST 또는 MAnaGER의 사원들의 사원 번호, 이름 ,입사일,
-- 바로 전에 입사한 사원의 입사일, 바로 다음에 입사한 사원의 입사일 출력
SELECT empno, ename, hiredate,
       LAG(hiredate,1) over (order by hiredate asc) "전 행",
       LEAD(hiredate,1) over (order by hiredate asc) "다음 행"
  FROM emp
  WHERE job in ('ANALYST', 'MANAGER');

-- 부서 번호, 사원 번호, 이름, 입사일, 바로 전에 입사한 사원의 입사일을 출력하고
-- 바로 다음에 입사한 사원의 입사일을 출력하는데, 부서 번호변호별로 구분해서 출력
SELECT deptno, empno, ename, hiredate,
       LAG(hiredate,1) over (partition by deptno order by hiredate asc) "전 행",
       LEAD(hiredate,1) over (partition by deptno order by hiredate asc) "다음 행"
  FROM emp;
  
-- 047 COLUMN을 ROW로 출력하기 1 - SUM + DECODE
-- 부서 번호, 부서 번호별 토탈  월급을 가로로 출력
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
       SUM(DECODE(deptno, 20, sal)) as "20",
       SUM(DECODE(deptno, 30, sal)) as "30"
 FROM emp;
 
 -- 부서 번호가 10번이면 월급이 출력, 아니면 NULL
SELECT deptno, DECODE(deptno, 10, sal) as "10"
  FROM emp;

-- 직업, 직업별 토탈 월급을 가로로 출력
SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
  FROM emp;
  
-- 048 COLUMN을 ROW로 출력하기 2 - PIVOT
-- 부서번호,  부서 번호별 토탈 월급
SELECT *
  FROM (select deptno, sal from emp)
  PIVOT (sum(sal) for deptno in (10,20,30));
  
-- 049 COLUMN을 ROW로 출력하기 2 - UNPIVOT

SELECT *
  FROM order2
  UNPIVOT (건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));
  
-- 050 데이터 분석 함수로 누적 데이터 출력하기 (SUM OVER)
SELECT empno, ename, sal, SUM(SAL) OVER (ORDER BY empno ROWS
                                        BETWEEN UNBOUNDED PRECEDING
                                        AND CURRENT ROW) 누적치
  FROM emp
  WHERE job in ('ANALYST', 'MANAGER');
