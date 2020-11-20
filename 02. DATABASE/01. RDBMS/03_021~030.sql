-- 021 특정 철자를 N개 만큼 채우기 (LPAD, RPAD)
-- 이름과 월급을 출력하는데 월급 컬럼의 자릿수를 10자리로 하고, 
-- 월급을 출력하고 남은 나머지 자리에 별표(*)를 채워 출력
SELECT ename, LPAD(sal,10,'*') as salary1,
       RPAD(sal,10,'*') as salary2
  FROM emp;
  -- LPAD : 왼쪽으로(Left) 채워 넣다(PAD)
  -- RPAD : 오른쪽으로(Right) 채워 넣다(PAD)

SELECT ename, sal, lpad('■', round(sal/100), '■') as bar_chart
  FROM emp;

-- 022 특정 철자 잘라내기 (TRIM, RTRIM, LTRIM)
SELECT 'smith', LTRIM('smith', 's'), RTRIM('smith','h'), TRIM('s' from 'smiths')
  FROM dual;

INSERT INTO emp(empno, ename, sal, job, deptno) 
VALUES (8291, 'JACK ', 3000, 'SALESMAN', 30);
commit;

SELECT ename, sal
  FROM emp
  WHERE ename = 'JACK';
  -- ,아무것도 출력되지 않음
  
SELECT ename, sal
  FROM emp
  WHERE RTRIM(ename)='JACK';
  
-- 023 반올림해서 출력하기(ROUND)
SELECT '876.567' as 숫자, ROUND(876.567,1)
  FROM dual;
  
-- 024 숫자를 버리고 출력하기(TRUNC)
SELECT '876.567' as 숫자, TRUNC(876.567,1)
  FROM dual;
  
-- 025 나눈 나머지 값 출력하기(MOD)
SELECT MOD(10,3)
  FROM DUAL;
  
-- 사원번호와 사원 번호가 홀수이면 1, 짝수이면 0을 출력
SELECT empno, MOD(empno,2)
  FROM emp;
  
-- 사원 번호가 짝수인 사원들의 사원 번호와 이름을 출력
SELECT empno, ename
  FROM emp
  WHERE MOD(empno,2) = 0;
  
-- 10을 3으로 나눈 몫을 출력
SELECT FLOOR(10/3)
  FROM DUAL;
  
-- 026 날짜 간 개월 수 출력하기 (MONTHS_BETWEEN)
-- 이름을 출력하고 입사한 날짜부터 오늘까지 총 몇달을 근무했는지 출력
SELECT ename, TRUNC(MONTHS_BETWEEN(sysdate,hiredate))
  FROM emp;
-- MONTHS_BETWEEN(최신날짜, 예전날짜)

-- 027 개월 수 더한 날짜 출력하기 (ADD_MONTHS)
-- 2019년 5월 1로부터 100달 뒤 날짜 출력
SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100)
  FROM DUAL;
-- 2019년 5월 1일부터 100일 후에 돌아오는 날짜 출력
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100
  FROM DUAL;
-- 일(DD)이 아니라 달이 되면 달의 기준을 30일로 해야할지 31로 해야 할지 정하기 어려움
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '100' month
  FROM DUAL;
-- 2019년 5월 1일부터 1년 3개월 후의 날짜를  출력
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
  FROM DUAL;

-- 028 특정 날짜 뒤에 오는 요일 날짜 출력하기(NEXT_DAY)
SELECT '2019/05/22' as 날짜, NEXT_DAY('2019/05/22', '월요일')
  FROM DUAL;

-- 오늘로부터 앞으로 돌아올 화요일의 날짜를 출력
SELECT NEXT_DAY(SYSDATE, '화요일') as "다음 날짜"
  FROM DUAL;
  
-- 2019년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜 출력
SELECT NEXT_DAY(ADD_MONTHS('2019/05/22',100),'화요일')as"다음 날짜"
  FROM DUAL;

-- 오늘부터 100달 뒤에 돌아오는 월요일의 날짜 출력
SELECT NEXT_DAY(ADD_MONTHS(sysdate,100),'월요일')as"다음 날짜"
  FROM DUAL;
  
-- 029 특정 날짜가 있는 달의 마지막 날짜 출력하기(LAST_DAY_
-- 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 출력
SELECT '19/05/22' as 날짜, LAST_DAY('19/05/22') as "마지막 날짜"
  FROM DUAL;
  
-- 오늘부터 이번달 말일까지 총 며칠 남았는지 출력
SELECT LAST_DAY(SYSDATE) - SYSDATE as "남은 날짜"
  FROM DUAL;

-- 이름이 KING 인 사원의 이름, 입사일, 입사한 달의 마지막 날짜 출력
SELECT ename, hiredate, LAST_DAY(hiredate)
  FROM emp
  WHERE ename='KING';
  
-- 030 문자형으로 데이터 유형 변환하기 (TO_CHAR)
-- 이름이 SCOTT인 사원의 이름과 입사한 요일을 출력하고 
-- SCOTT의 월급에 천 단위를 구분할 수 있는 콤마(,)를 붙여 출력
SELECT ename, TO_CHAR(hiredate,'DAY') as 요일,
       TO_CHAR(sal,'999,999') as 월급  
  FROM emp
  WHERE ename = 'SCOTT';
  -- TO_CHAR(hiredate,'DAY')는 입사일을 요일로 출력
  -- TO_CHAR(sal,'999,999')는 월급을 출력할 때 천 단위를 표시하여 출력
  -- 숫자형 데이터 유형을 문자형으로 변환하거나 날짜형 데이터 유형을 문자형으로 변환할 때
  -- TO_CHAR 함수를 사용
  
SELECT hiredate, TO_CHAR(hiredate,'RRRR') as 연도,
       TO_CHAR(hiredate,'MM') as 달,
       TO_CHAR(hiredate,'DD') as 일,
       TO_CHAR(hiredate,'DAY') as 요일
  FROM emp
  WHERE ename='KING';
  
  -- 날짜 포맷
  -- 연도 : RRRR,YYYY,RR,YY
  -- 월 : MM,MON
  -- 일 : DD
  -- 요일 : DAY,DY
  -- 주 : WW
  -- 시간 : HH,HH24
  -- 분 : MI
  -- 초 : SS

-- 1981년도에 입사한 사원의 이름과 입사일을 출력하는 쿼리
SELECT ename, hiredate
  FROM emp
  WHERE TO_CHAR(hiredate,'RRRR') = '1981';
  
-- 알파벳 L을 사요앟면 화폐 단위 |(원화)를 붙여 출력할 수 있음
SELECT ename as 이름, TO_CHAR(sal*200, 'L999,999,999') as 월급
  FROM emp;
