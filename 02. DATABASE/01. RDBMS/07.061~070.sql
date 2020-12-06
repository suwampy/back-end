
-- 061 여러 테이블의 데이터를 조인해서 출력하기 ④ SELF JOIN
-- 자기자신의 테이블을 조인하기 위해서는 SELF JOIN을 사용
-- 사원 테이블 자기 자신의 테이블과 조인하여 이름, 직업, 해당 사원의 관리자 이름과
-- 관리자의 직업을 출력
SELECT e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
  FROM emp e, emp m
  WHERE e.mgr = m.empno and e.job='SALESMAN';

-- 061 여러 테이블의 데이터를 조인해서 출력하기 ⑤ ON절
-- ANSI 조인 작성법
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
  FROM emp e JOIN dept d
  ON (e.deptno = d.deptno)
  WHERE e.job='SALESMAN';
  
-- 063 여러 테이블의 데이터를 조인해서 출력하기 ⑤ USING절
-- USING 조인 작성법  
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
  FROM emp e join dept d
  USING (deptno)
  WHERE e.job='SALESMAN';
  
-- 064 여러 테이블의 데이터를 조인해서 출력하기 ⑥ NATURAL JOIN
-- 조인 조건을 주지 않고 EQUI 조인
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
  FROM emp e NATURAL JOIN dept d
  WHERE e.job='SALESMAN';
  
-- 065 여러 테이블의 데이터를 조인해서 출력하기 ⑦ (LEFT/RIGHT OUTER JOIN)
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
  FROM emp e RIGHT OUTER JOIN dept d
  ON (e.deptno = d.deptno);
  
 -- 066 여러 테이블의 데이터를 조인해서 출력하기 ⑧ (FULL OUTER JOIN)
--LEFT 조인과 RIGHT 종인을 하번에 수행하여 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
  FROM emp e FULL OUTER JOIN dept d
  ON (e.deptno =d.deptno);
  
-- 067 집합 연산자로 데이터를 위아래로 연결하기 ① UNION ALL
-- 여러 개의 쿼리 결과 데이터를 위아래로 하나의 결과로 출력
SELECT deptno, sum(sal)
  FROM emp
  GROUP BY deptno
UNION ALL
SELECT TO_NUMBER(null) as deptno, sum(sal)
  FROM emp;
  -- 집합 연산자 작성 시 주의사항
  -- UNION ALL 위쪽 쿼리와 아래쪽 쿼리 컬럼의 개수가 동일해야 함
  -- UNION ALL 위쪽 쿼리와 아래쪽 쿼리 컬럼의 데이터 타입이 동일해야 함
  -- 결과로 출력되는 컬럼명은 위쪽 쿼리의 컬럼명으로 출력됨
  -- ORDER BY 절은 제일 아래쪽 쿼리에만 작성할 수 있음

-- 068 집합 연산자로 데이터를 위아래로 연결하기 ② UNION
-- 부서 번호와 부서 번호별 토탈 월급을 출ㄹ력하는데,
-- 맨 아래 행에 토탈 월급을 출력
SELECT deptno, sum(sal)
  FROM emp
  GROUP BY deptno
UNION
SELECT null as deptno, sum(sal)
  FROM emp;
  -- UNION과 UNION ALL의 다린점
  -- 중복된 데이터를 하나의 고유한 값으로 출력
  -- 첫 번째 컬럼의 데이터를 기준으로 내림차순으로 정렬하여 출력

--069 집합 연산자로 데이터의 교집합을 출력(INTERSECT)
-- 부서 번호 10번, 20번인 사원들을 출력하는 쿼리의 결과와
-- 부서 번호 20번, 30번을 출력하는 쿼리 결과의 교집합을 출력
SELECT ename, sal, job, deptno
  FROM emp
  WHERE deptno in (10,20)
INTERSECT
SELECT ename, sal, job, deptno
  FROM emp
  WHERE deptno in (20,30);
  
--070 집합 연산자로 데이터의 차이를 출력하기(MINUS)
-- 부서 번호 10번, 20번을 출력하는 쿼리의 결과에서
-- 부서 번호 20번, 30번을 출력하는 쿼리의 결과 차이를 출력
SELECT ename, sal, job, deptno
  FROM emp
  WHERE deptno in (10,20)
MINUS
SELECT ename, sal, job, deptno
  FROM emp
  WHERE deptno in (20,30);
