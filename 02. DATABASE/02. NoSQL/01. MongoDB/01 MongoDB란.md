## 1. DBMS? NoSQL DBMS?
- 기존의 데이터 베이스 관리 시스템(DBMS)은 대량의 데이터를 저장하고 관리할 수 있었다.
   - 정의 : 형식, 구조, 제약을 통해 데이털르 균일하게 관리하도록 도와줌
   - 구축 : 관리하는 정보를 기억 장치에 저장해줌
   - 조작 : 질의 밑 다른 기능을 통해 데이터를 독립적이고 효율적으로 접근하게 해줌
   - 공유 : 데이터에 동시에 접근할 수 있게 해줌
   - 보호 : 보안을 유지시키고, 충돌을 복구할 수 있게 해줌
   - 유지보수 : 시간이 지나면서 변화하는 요구사항을 반영할 수 있게 해줌

1. NoSQL DBMS?
   - NoSQL DBMS : 기존의 관계형 DBMS가 아닌 것
   - No SQL DBMS 의 분류
   |종류|예시|
   |----------|----|
   |키-값 스토어|Redis, Dynamo|
   |컬럼 지향 스토어|HBase,Cassandra|
   |도큐먼트 지향 스토어|MongoDB|
   |그래프 데이터베이스|Neo4J|

2. NoSQL : 친숙함과 이용의 편리성
   - DBMS 중 대다수의 경우 SQL(Structured Query Language) 라는 언어를 사용해서 정보를 불러오거나 관리해야 한다. SQL은 관계형 데이터베이스 관리 시스템을 위해 특수 설계된 언어이므로, 데이터베이스에 질의하기 위한 목적이 아니라면 사용할 일이 없다.
   - <b>그러나</b> MongoDB는 SQL 대신 <b>JavaScript</B>를 활용하고 있다. 더불어, 관계형 DBMS에서 테이블을 이용해 정보를 저장하는 방식과는 달리 웹 서버와 통신할 때 자주 쓰이는 <b>JSON</b>과 유사한 형태로 저장하는 방식을 사용하고 있다.
   
3. NoSQL : 복제(Replicate), 샤딩(Sharding)

## 2. 언제 써야하나

1. 스키마가 자주 바뀌는 환경
2. 분산 컴퓨팅 

## 3. MongoDB 구조

1. MongoDB 구성 요소 : 도큐먼트 - 컬렉션 - 데이터베이스

```sh
{
  name : "yusuwan",
  agge : 26,
  status : "B",
  groups : ["family", "sports"],
}
```

2. 데이터베이스와 컬렉션 생성

![a1](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FlVkU6%2FbtqF5zW22bE%2F42ehjv4FyU5ictDg1CJ4IK%2Fimg.png)

|구성|명칭|
|----------|----|
|데이터베이스|testDB|
|컬렉션|myCollection|
|도큐먼트|{x:1} <br>{x: [1,2,3], y:4} |

3. 데이터베이스왘 ㅓㄹ렉션 조회

## 4. 데이터 타입

- 도큐먼트는 BSON 구조를 가진다. BSON 구조의 데이터 타입

|번호|타입|이름|비고|
|---|---|---|---|
|1|Dobule|"double"| |
|2|String|"string"| |
|3|Object|"object"| |
|4|Array|"array"| |
|5|Binary data|"binData"| |
|6|Undefined|"undefined"| Deprecated|
|7|ObjectId|"objectId"| |
|8|Boolean|"bool"| |
|9|Date|"date"| |
|10|Null|"null"| |
|11|Regular Expression|"regex"| |
|12|DBPointer|"dbPointer"|Deprecated |
|13|JavaScript|"javascript"| |
|14|Symbol|"symbol"|Deprecated|
|15|JavaScript (with scope)|"javascriptWithScope"| |
|16|32-bit integer|"int"| |
|17|Timestamp|"timestamp"| |
|18|64-bit integer|"long"| |
|19|Decimal128|"decimal"| |
|-1|Min key|"minKey"| |
|127|Max key|"maxKey"| |


- 기본 타입 : JSON에서 값으로 가질 수 있던 타입 중 기본적인 타입은 BSON에서도 값으로 가질 수 있다.
