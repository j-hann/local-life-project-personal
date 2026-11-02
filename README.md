# LocalLife Backend — 개인 확장 개발

> 기존 팀 프로젝트 [**LocalLife Backend**](https://github.com/salayo-team/local-life-backend)를 기반으로,    
> 담당했던 **체험 프로그램·일정·예약·결제·검색 영역을 확장하는 개인 프로젝트**

기존 서비스의 구조와 기능을 유지하면서 `program`, `programschedule`, `reservation`, `payment`, `paymenthistory`를 중심으로 기존 구현 보완 및 운영 관점의 기능 단계적 확장

확장 내용과 검증 결과는 구현 진행에 따라 문서에 추가
  
---  

## 프로젝트 구분

| 구분 | 내용 |  
| --- | --- |  
| **Original Project** | [salayo-team/local-life-backend](https://github.com/salayo-team/local-life-backend) |  
| **This Repository** | 기존 팀 프로젝트 기반 개인 확장 개발 저장소 |  
| **Baseline** | `team-project-baseline` |  
| **Extension Scope** | 프로그램, 일정, 예약, 결제, 검색 및 운영 기능 |  

> [!NOTE]  
> `team-project-baseline` 태그까지 기존 팀 프로젝트 기준 코드  > **이후 커밋부터 개인 확장 개발 작업으로 관리**
  

---  

## 담당 범위

기존 팀 프로젝트에서 담당한 주요 영역

- 체험 프로그램 및 일정 도메인 설계·운영 로직
- QueryDSL 기반 검색·필터·정렬
- MySQL Full-Text Search + Ngram parser 기반 키워드 검색
- 예약 생성·취소·크리에이터 거절 및 상태 검증
- PortOne 결제 검증·환불
- `PaymentHistory` 기반 결제 성공·실패 이력 관리
- Flyway 기반 DB 인덱스 변경 관리

---  

## 기술 스택

| 구분 | 기술 |  
| --- | --- |  
| **Backend** | Java 21, Spring Boot 3.3.1 |  
| **Persistence** | Spring Data JPA, QueryDSL 5 |  
| **Database** | MySQL 8, Flyway |  
| **Search** | MySQL Full-Text Search, Ngram parser |  
| **Payment** | PortOne (Iamport REST Client) |  
| **API Docs** | springdoc-openapi |  
  

---  

## 도메인 구조

```text  
Program 1 ─── N ProgramDay  
        ├──── N ProgramScheduleTime        └──── N ProgramSchedule 1 ─── N Reservation                                      │                                      └──── 1 Payment 1 ─── N PaymentHistory  
```  

- `ProgramDay`, `ProgramScheduleTime`, `ProgramSchedule` — `Program`과 각각 별도 엔티티
- `ProgramSchedule` — 실제 예약 가능한 일정 단위
- `Reservation` — `ProgramSchedule`을 참조하는 별도 엔티티
- `Payment` — `Reservation`과 1:1 연결
- `PaymentHistory` — 하나의 `Payment`에 여러 처리 이력 저장

---  

## 핵심 구현

### 프로그램 · 일정

프로그램 등록 시 운영 기간, 요일, 회차 시간을 조합하여 실제 예약 단위인 `ProgramSchedule` 자동 생성

주요 검증

- 승인된 로컬 크리에이터의 프로그램 등록 권한 검증
- 가격·할인율·최종 금액 검증
- 최소·최대 정원 검증
- 운영 기간 검증
- 동일 크리에이터의 일정 중복 검증
- 활성 예약 확인 후 프로그램 및 일정 soft delete

---  

### 검색

QueryDSL 기반 동적 검색 및 조건 조합

- 지역
- 적성 카테고리
- 지역 특화 여부
- 가격 범위
- 최신순 / 가격순 / 후기순 / 평점순
- 제목·사업자명 키워드

MySQL Full-Text Search와 Ngram parser 기반 키워드 검색

```sql  
MATCH(title, business_name)  
AGAINST (... IN BOOLEAN MODE)  
```  

검색어 존재 시 **Full-Text score 우선 정렬 + 사용자 선택 정렬 조건 적용**

Full-Text 인덱스는 Flyway migration으로 관리
  

---  

### 예약 · 결제

기본 예약·결제 흐름

```text  
REQUESTED  
   ↓PAYMENT_PENDING  
   ↓AWAITING_APPROVAL  
   ↓APPROVED  
```  

예약 취소와 크리에이터 거절은 **PG 환불 성공 후 예약 상태 변경**

```text  
사용자 취소  
  
AWAITING_APPROVAL / APPROVED  
              ↓           PG 환불  
              ↓           CANCELED  
```  

```text  
크리에이터 거절  
  
AWAITING_APPROVAL  
        ↓     PG 환불  
        ↓     REJECTED  
```  

`REJECTED`, `CANCELED`, `EXPIRED` 상태는 비활성 예약으로 분류하여 동일 일정의 신규 예약 허용
  

---  

### 결제 이력 · 실패 처리

`PaymentHistory`를 통한 결제 처리 시점 스냅샷 관리

- 주문 / PG 식별자
- 결제 금액 및 수단
- 결제·환불 상태
- 카드 정보 스냅샷
- 환불 사유
- 실패 사유 및 PG 오류 메시지

결제·환불 실패 이력은 별도 트랜잭션으로 저장

```java  
@Transactional(propagation = REQUIRES_NEW)  
```  

상위 결제 트랜잭션 롤백과 무관하게 실패 원인을 별도 커밋하여 장애 분석 및 재처리 대상 식별에 활용
  

---  

## 개인 확장 방향

기존 구현을 기반으로 한 주요 확장 방향

- 검색 정확도 및 정렬 기준 개선
- 예약·결제 상태 흐름 보완
- 동시 예약 및 정원 처리 개선
- 결제·환불 안정성 강화
- 주요 서비스 지표 및 장애 상황 모니터링
- 운영 환경을 고려한 기능 확장

> [!NOTE]  
> 기존 도메인의 미완성 흐름과 운영상 문제 검증·보완 후 검색, 결제, 운영 환경 단계적 확장  > 구체적인 확장 내용과 결과는 **실제 구현 완료 시점에 추가**


---  

## 관련 코드

| 영역 | 경로 |  
| --- | --- |  
| **Program** | `src/main/java/com/salayo/locallifebackend/domain/program` |  
| **ProgramSchedule** | `src/main/java/com/salayo/locallifebackend/domain/programschedule` |  
| **Reservation** | `src/main/java/com/salayo/locallifebackend/domain/reservation` |  
| **Payment** | `src/main/java/com/salayo/locallifebackend/domain/payment` |  
| **DB Migration** | `src/main/resources/db/migration` |  
  

---

## 커밋 컨벤션

| 이모지 | 타입 | 설명 |  
| --- | --- | --- |  
| 🎉 | `begin` | 프로젝트 시작 |  
| ✨ | `feat` | 새로운 기능 추가 및 구현 |  
| 📝 | `docs` | 문서 파일 추가 및 수정 |  
| 🔧 | `add` | 기존 기능에 코드 추가 및 수정 |  
| ✏️ | `typos` | 단순 오타 수정 |  
| 🐛 | `fix` | 버그 및 에러 수정 |  
| ✅ | `test` | 테스트 코드 작성 및 수정 |  
| 🚚 | `rename` | 파일·경로 이동 또는 이름 변경 |  
| ♻️ | `refactor` | 코드 리팩토링 |  
| 💡 | `comment` | 주석 추가 및 변경 |  
| 🔥 | `remove` | 파일·코드 삭제 |  
| 🔀 | `branch` | 브랜치 추가 및 병합 |  
| 🏗️ | `chore` | 빌드·패키지 관리·환경 설정 변경 |
