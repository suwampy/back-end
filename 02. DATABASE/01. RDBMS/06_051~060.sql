-- 051 데이터 분석 함수로 비율 출력하기 (RATIO_TO_REPORT)
-- 부서 번호가 20번인 사원들의 사원 번호, 이름, 월급을 출력하고
-- 20번부서 번호 내에서 자신의 월급 비율이 어떻게 되는지 출력
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) OVER () as 비율
  FROM emp
  WHERE deptno = 20;
  
  
-- 052 데이터 분석 함수로 집계 결과 출력하기 ① ROLLUP
-- 직업과 직업별 토탈 우러급을 출력하는데,
-- 맨 마지막 행에 토탈 월급을 출력
SELECT job, sum(sal)
  FROM emp
  GROUP BY ROLLUP(job);
  -- ROLLUP : 직업과 직업별 토탈 월급을 출력, JOB 컬럼의 데이터 오름차순으로 정렬
  -- 맨 아래쪽에 전체 토탈 월급을 추가적으로 출력하는 쿼리
  
SELECT deptno, job, sum(sal)
  FROM emp
  GROUP BY ROLLUP(deptno, job);
  -- 부서 번호별 직업별 토탈 월급
  -- 부서 번호별 토탈 월급
  -- 전체 토탈 월급

-- 053 데이터 분석 함수로 집계 결과 출력하기 ②(CUBE)
SELECT job, sum(sal)
 FROM emp
 GROUP BY CUBE(job);
 
 -- 054 데이터 분석 함수로 집계 결과 출력하기 ③(GROUPING SETS)
 -- 부서 번호와 직업, 부서 번호별 토탈 월급과 직업별 토탈 월급, 전체 토탈 월급 출력
 SELECT deptno, job, sum(sal)
   FROM emp
   GROUP BY GROUPING SETS((deptno),(job),());
   
-- 055 데이터 분석 함수로 출력 결과 넘버링하기
-- (ROW_NUMBER)
-- ROW_NUMBER : 출력되는순서대로 순위를 부여
SELECT empno, ename, sal, RANK() OVER (ORDER BY sal DESC) RANK,
                        DENSE_RANK() OVER (ORDER BY sal DESC) DENSE_RANK,
                        ROW_NUMBER() OVER (ORDER BY sal DESC) 번호
  FROM emp
  WHERE deptno = 20;
  
-- 부서 번호별로 월급에 대한 순위 출력 : PARTITION BY
SELECT deptno, ename, sal, ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC)번호
  FROM emp
  WHERE deptno in (10,20);
  
-- 056 출력되는 행 제한하기 ① (ROWNUM)
--사원 테이블에서 사원 번호, 이름, 직업, 월급을 상단 5개의 행만 출력
SELECT ROWNUM, empno, ename, job, sal
  FROM emp
 WHERE ROWNUM<=5;
-- 월급이 높은 사원 순으로 사원 번호, 이름, 직업, 월급을 4개의 행으로 제한해서 출력
SELECT empno, ename, job, sal
  FROM emp
  ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;
-- 월급기 높은 사원들 중 20%에 해당하는 사원들 출력
SELECT empno, ename, job, sal
  FROM emp
  ORDER BY sal desc
  FETCH FIRST 20 PERCENT ROWS ONLY;

-- 여러 테이블의 데이터를 조인해서 출력하기 ① EQUI JOIN
SELECT ename, loc
  FROM emp, dept
  WHERE emp.deptno = dept.deptno;
  
-- 057 여러 테이블의 데이터를 조인해서 출력하기 ② NON EQUI JOIN
-- 사원 테이블과 급여 등급 테이블을 조인하여 이름, 월급, 급여 등급 출력
SELECT e.ename, e.sal, s.grade
  FROM emp e, salgrade s
  WHERE e.sal BETWEEN s.losal and s.hisal;
  
-- 057 여러 테이블의 데이터를 조인해서 출력하기 ③ OUTER JOIN
-- 사원 테이블과 부선 테이블을 조인하여 
-- 이름과 부서 위치를 출력하는데,BOSTON도 같이 출력되게
SELECT e.ename, d.loc
  FROM emp e, dept d
  WHERE e.deptno (+)= d.deptno;
  -- LOC = BOSTON 이 출력됨.
  -- 위에 EQUI JOIN에서 BOSTON이 출력되지 않ㄴ은 이유는
  -- EMP 테이블에 40번 부서 번호가 없어서 DEPT테이블과 조인이 되지 않았기 때문
  -- BOSTON에는 사원이 배치되지 않았다. 라는 정보를 확인하려면
  -- OUTER JOIN 을 사용해야함.
  -- OUTER JOIN은 기존 EQUI JOIN 문법에 OUTER 조인 사인(+)만 추가한 것
