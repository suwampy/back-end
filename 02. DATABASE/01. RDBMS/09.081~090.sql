-- 081 : 데이터 저장 및 취소하기 (COMMIT, ROLLBACK)
-- COMMIT : COMMIT 이전에 수행했던 DML 작업들을 데이터베이스에 영구히 반영하는TCL
-- ROLLBACK : 마지막 COMMIT 명령어를 수행한 이후 DML문을 취소하는 TCL

-- 082 : 데이터 입력, 수정, 삭제 한번에 하기
-- 사원 테이블에 부서 위치 컬럼을 추가하고 
-- 부서 테이블을 이용하여 해당 사원의 부서 위치로 값이 갱신되도록 함
MERGE INTO emp e
USING dept d
ON (e.deptno = d.deptno)
WHEN MATCHED THEN
UPDATE set e.loc = d.loc
WHEN NOT MATCHED THEN
INSERT (e.empno, e.deptno, e.loc) VALUES (1111, d.deptno, d.loc);

-- 083 : 락(LOCK) 이해하기
-- 데이터의 일관성을 유지하기 위해서 사용.
-- 같은 데이터를 동시에 갱신할 수 없도록 한다

-- 084 : SELECT FOR UPDATE 절

-- 085 : 서브 쿼리를사용하여 데이터 입력
-- emp테이블의 구조를 그대로 복제한  emp2 테이블에
-- 부서번호가 10번인 사원들의 사원번호, 이름, 월급,부서 번호를
-- 한 번에 입력
INSERT INTO emp2(empno, ename, sal,deptno)
SELECT empno, ename, sal, deptno
  FROM emp
  WHERE deptno = 10;
  
-- 086 : 서브 쿼리를 사용하여 데이터 수정하기
UPDATE emp
  SET sal = (SELECT sal
              FROM emp
              WHERE ename='ALLEN')
WHERE job = 'SALESMAN';

-- 087 : 서브 쿼리를 사용하여 데이터 삭제하기
DELETE FROM emp
WHERE sal > (SELECT sal
             FROM emp
             WHERE ename='SCOTT');
             
-- 088 : 서브 쿼리를 사용하여 데이터 합치기
MERGE INTO dept d
USING (SELECT deptno, sum(sal) sumsal 
        FROM emp
        GROUP BY deptno) v
ON (d.deptno = v.deptno)
WHEN MATCHED THEN
UPDATE set d.sumsal = v.sumsal;

--089 계층형 질의문으로 서열을 주고 데이터 출력하기
-- 사원, 이름, 월급, 직업을 출력하는데
-- 사원들 간의 서열(LEVEL)을 같이 출력
SELECT *
FROM emp;
-- deptno 로 서열이 나뉘어짐
SELECT rpad('', level*3) || ename as employee, level, sal, job,deptno
  FROM emp
  START WITH ename ='KING' -- 루트 노드의 데이터를 지정함.
                           -- 루트 노드는 최상위 노드.
  CONNECT BY prior empno= mgr; -- 부모 노드와 자식 노드들 간의 관계를 지정
                               -- PRIOR을 가운데에 두고 왼쪽에 부모 노드가 되는 컬럼을 적고
                               -- 오른쪽에 자식 노드가 되는 컬럼을 기술
  
  -- 계층형 질의문
  -- node : 표시된 항목
  -- level : 트리 구조에서 각각의 계층
  -- root : 트리 구조에서 최상위에 있는 노드
  -- parent : 트리 구조에서 상위에 있는 노드
  -- child : 트리 구조에서 하위에 있는 노드

-- 090 계층형 질의문으로 서열을 주고 데이터 출력하기 2
SELECT rpad('', level*3 || ename ass\ empoyee, level, sal, job
  FROM emp
  START WITH ename='KING'
  CONNECT BY prior empno = mgr AND ename!='BLANK'; -- BLANK와BALNK의 직속 부하들은 출력 ㄴㄴ
