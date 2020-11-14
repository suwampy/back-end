-- 001 테이블에서 특정 열(COLUMN) 선택하기
SELECT empno, ename, sal
FROM emp;
-- 가독성을 높이기 위해 SQL은 대문자로 작성하고 컬럼명과 테이블명은 소문자로 작성

-- 002 테이블에서 모든 열(COLUMN) 츨력하기
SELECT *
FROM emp;
-- 전체 열 조회 : *
-- 모든 컬럼을 출력하고 맨 끝에 다시 한번 특정 컬럼을 한번 더 출력해야 하는 경우
-- : *(별표) 앞에 '테이블명.'을 붙여 작성
SELECT dept.*, deptno
FROM dept;

-- 003 컬럼 별칭을 사용하여 출력되는 컬럼명 변경하기
SELECT empno as "사원번호",  ename as "사원이름", sal as "Salary"
FROM emp;
-- 출력되는 컬럼명을 변경하고자 할 때는 컬럼명 다음에 as를 작성하고 출력하고 싶은 컬럼명을 기술
-- : 컬럼 별칭 (column alias)
-- 컬럼 별칭에는 더블 쿼테이션 마크를 감싸줘야한다

-- 더블 쿼테이션 마크로 감싸줘야 할 때
-- 1. 대소문자를 구분하여 출력할 때
-- 2. 공백문자를 출력할 때
-- 3. 특수문자를 출력할 때($,_,# 만 가능)

-- 수식을 사용하여 결과를 출력할 때 컬럼 별칭이 유용
SELECT ename, sal*(12+3000)
  FROM emp;

-- 수식을 사용할 경우 출력되는 컬럼명도 수식으로 출력됨
SELECT ename, sal*(12+3000) as 월급
  FROM emp;
  
-- 수식에 컬럼 별칭을 사용하면 ORDER BY절을 사용할 때 유용
-- ORDER BY절에 수식명을 작성하지 않고 컬럼 별칭만 사용하면 되기 때문에 SQL 작성이 간편해짐
SELECT ename, sal*(12+3000) as 월급
  FROM emp
  ORDER BY 월급 desc;

-- 004 연결 연산자 사용하기 (||)
SELECT ename || sal
  FROM emp;

-- 연결 연산자를 이용하면 컬럼과 컬럼을 서로 연결해서 출력할 수 잇음
-- emp 테이블로부터 이름과 월급을 선택하여 연결 연산자로 연결하여 출력

SELECT ename || '의 월급은' || sal || '입니다' as 월급정보
  FROM emp;

-- 005 중복된 데이터를 제거해서 출력하기(DISTINCT)
SELECT DISTINCT job
  FROM emp;

-- UNIQUE를 사용해도 됨
SELECT UNIQUE job
  FROM emp;

-- 006 데이터를 정렬해서 출력하기(ORDER BY)
-- 이름과 월급을 출력하는데 월급이 낮은 사원부터 출력
SELECT ename, sal
  FROM emp
  ORDER BY sal asc;
-- ORDER BY절은 SQL 작성 시에도 맨 마지막에 작성하고 오라클이 실행할 때도 맨마지막에 실행함
-- ORDER BY절은 맨 마지막에 실행되기 때문에 SELECT절에 사용한 컬럼 별칭을
-- ORDER BY절에 사용할 수 있다.
SELECT ename, sal as 월급
  FROM emp
  ORDER BY 월급 asc;
  
-- ORDER BY 절에는 컬럼을 여러개 작성할 수도 있다
SELECT ename, deptno, sal
  FROM emp
  ORDER BY deptno asc, sal desc;
-- 부서번호(deptno)를 먼저 ascending하게 정렬하고 부서 번호를 ascending하게
-- 정렬된 것을 기준으로 월급을 descending하게 정렬하고 있다

SELECT ename, deptno, sal
  FROM emp
  ORDER BY 2 asc, 3 desc;
-- ORDER BY절에 작성한 숫자는 SELECT절 컬럼의 순서

-- 007 WHERE절 배우기 ① (숫자 데이터 검색)
SELECT ename, sal, job
  FROM emp
  WHERE sal = 3000;

-- WHERE절 비교연산자
-- > 크다
-- < 작다
-- BETWEEN AND ~사이에 있는
-- LIKE 일치하는 문자 패턴 검색
-- IS NULL NULL 값인지 여부
-- IN 값 리스트중 일치하는 값 검색

-- 월급이 3000 이상인 사원들의 이름과 월급을 출력하는 SQL 문장
SELECT ename as 이름, sal as 월급
  FROM emp
  WHERE sal >= 3000;
  
SELECT ename as 이름, sal as 월급
  FROM emp
  WHERE 월급 >= 3000;
-- 에러 발생 : 오라클은 FROM 절을 실행하고나서 WHERE절을 실행하기 때문에 에러가 발생
-- 실행 순서 : ① FROM emp ② WHERE 월급 >= 3000 ③ SELECT ename as 이름, sal as 월급
-- FROM절을 실행하면서 데이터베이스에서 emp 테이블을 가져오고 WHERE절을 실행하면서
-- emp 테이블에서 한글로 된 '월급'을 찾아봄 => 없으므로 에러발생

-- 008 WHERE절 배우기 ② (문자와 날짜 검색)
SELECT ename, sal, job, hiredate, deptno
  FROM emp
  WHERE ename='SCOTT';
-- 문자를 검색할 때는 문자 양쪽에 싱글 쿼에티션 마크를 둘러 감싸주어야함

SELECT ename, hiredate
  FROM emp
  WHERE hiredate = '81/11/17';
-- 문자뿐만 아니라 날짜도 양쪽에 싱글 쿼테이션 마크를 감싸주어야 함
-- 날짜 데이터 검색의 경우 현재 접속한 세션의 날짜 형식에 맞춰 작성해주어야 한다
-- 세션의 날짜 형식 : NSL_SESSION_PARAMETERS 조회

-- 009 산술 연산자 배우기(*,/,+,-)
-- 연봉이 36000 이상인 사원들의 이름과 연봉 출력
SELECT ename, sal*12 as 연봉
  FROM emp
  WHERE sal*12 >= 36000;

-- 부서 번호가 10번인 사원들의 이름, 월급, 커미션, 월급+커미션을 출력
SELECT ename, sal, comm, sal +comm
 FROM emp
 WHERE deptno = 10;
-- 데이터가 없음 : NULL 값. 데이터가 할당되지 않은 상태, 알 수 없는 값
-- 월급+커미션의 결과도 NULL 값으로 출력됨. NULL 이 알 수 없는 값이므로 5000+NULL도 NULL로 출력
-- => NULL이 아닌 숫자로 변경해주어야 월급+커미션 값이 출력됨
SELECT sal+NVL(comm,0)
  FROM emp
  WHERE deptno='10';
-- NVL 함수 : NULL 데이터를 처리하는 함수
-- NVL(comm,0)은 comm을 출력할 때 comm이 NULL이면 0으로 출력하는 함수

-- 010 비교 연산자 배우기 ①(>,<,>=,<=,=,!=,<>,^=)
-- 월급이 1200 이하인 사원들의 이름과 월급, 직업, 부서 번호 출력
SELECT ename, sal, job, deptno
  FROM emp
  WHERE sal <= 1200;
