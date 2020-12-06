-- 071 서브 쿼리 사용하기 ① 단일행 서브쿼리
-- JONES보다 더 많은 월급을 받는 사원들으 ㅣ이름과 월급을 출력
SELECT ename, sal
  FROM emp
  WHERE sal > (SELECT sal
               FROM EMP
               WHERE ename='JONES');
               
-- 072 서브 쿼리 사용하기 ② 다중행 서브쿼리
-- 특정 쿼리에서 검색한 여러 값을 다른 쿼리에서 받아 검색
-- 직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들으 ㅣ이름과 월급 출력
SELECT ename, sal
 FROM emp
 WHERE sal in (SELECT sal
               FROM emp
               WHERE job='SALESMAN');
               -- 직업이 SALESMAN인 사원들이 한 명이 아 니라
               -- 여러 명이기 때문에 이퀄을 사용하면 에러 발생
-- 단일 행 서브쿼리: 서브 쿼리에서 메인 쿼리로 하나의 값이 반환됨
-- 다중 행 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 여러 개의 값이 반환됨
--                  (=,!=,>,<,>=,>=)
-- 다중 컬럼 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 여러 개의 켤럼 값이 반환됨
--                  (in,not in,>any,<any,>all,<all)

-- 073 서브 쿼리 사용하기 ③ NOT IN
-- 특정 쿼리에서 검색한 데이터 중ㅇ 다른 쿼리에 없는 데이터를 검색하려면
-- NOT IN 연산자 사용
-- 관리자가 아닌 사원들의 이름과 월급과 직업을 출력
SELECT ename, sal, job
  FROM emp
  WHERE empno not in (SELECT mgr
                      FROM emp
                      WHERE mgr is not null);

-- 074 서브 쿼리 사용하기 ④ EXISTS와 NOT EXISTS
-- 부서 테이블에 있는 부서 번호 중에서
-- 사원 테이블에도 존재하는 부서 번호의 부서 번호, 부서명, 부서 위치 출력
SELECT *
  FROM dept d
  WHERE EXISTS (SELECT *
                FROM emp e
                WHERE e.deptno = d.deptno);
-- DEPT 테이블에는 존재하는 부서 번호인데
-- EMP 테이블에 존재하지 않는 데이터를 검색할 때는
--- NOT EXIST 문 사용
SELECT *
  FROM dept d
  WHERE NOT EXISTS (SELECT *
                    FROM emp e
                    WHERE e.deptno = d.deptno);
                    
-- 075 서브 쿼리 사용하기 ⑤ HAVING절의 서브 쿼리
-- 그룹 함수로 검색된 데이터 간의 비교 방법 : HAVING절
-- 직업과 직업별 토탈 월급을 출력하는데, 직업이 SALESMAN인 사원들의 토탈 월급보다
--- 더 큰 값들만 출력
SELECT job, sum(sal)
  FROM emp
  GROUP BY job
  HAVING sum(sal) > (SELECT sum(sal)
                      FROM emp
                      WHERE job = 'SALESMAN');\
-- 그룹 함수를 이용한 데이터 검색은
-- WHERE 절이 아니니 HAVING 절에 작성해야 함

-- 076 서브 쿼리 사용하기 ⑥ FROM 절의 서브 쿼리
-- 이름과 월급의 순위를 출력하는데 순위가 1위인 사원 출력
SELECT v.ename, v.sal, v.순위
  FROM (SELECT ename, sal, rank() over(order by sal desc) 순위 FROM emp) v
  WHERE v.순위=1;

-- 077 서브 쿼리 사용하기 ⑦ SELECT 절의 서브 쿼리
-- 직업니 SALESMAN인 사원들의 이름과 월급을출력하나ㅡㄴ데
-- 직업이 SALESMAN인 사원들으 ㅣ최대 월급과 최소 월급 출력
SELECT ename, sal, (SELECT MAX(sal) from EMP WHERE job='SALESMAN') as 최대월급,
                   (SELECT MIN(sal) from EMP WHERE job='SALESMAN') as 최소월급
  FROM emp
  WHERE job = 'SALESMAN';
  
-- 078 데이터 입력하기 INSERT
INSERT INTO emp(empno, ename, sal, hiredate, job)
  VALUES(2812,'JACK',3500,TO_DATE('2019/06/05', 'RRRR/MM/DD'),'ANALYST');
  
-- 079 데이터 수정하기 UPDATE
UPDATE emp
  SET sal = 3200
  WHERE ename = 'SCOTT';

-- 080 데이터 삭제하기 DELECT, TRUNCATE, DROP
DELETE FROM emp
WHERE ename = 'SCOTT';

DELETE FROM emp;

TRUNCATE TABEL emp;

DROP TABLE emp;
