# Wakapi Setup

WakaTime 호환 시간 추적 도구입니다.

## 필수 작업

### 1. PostgreSQL 데이터베이스 생성

```sql
CREATE DATABASE wakapi;
CREATE USER wakapi WITH ENCRYPTED PASSWORD 'yousshallnotpass';
GRANT ALL PRIVILEGES ON DATABASE wakapi TO wakapi;
```

### 2. Secret 업데이트

`secret.yml` 파일에서 다음 값들을 변경하세요:

```bash
# Password Salt 생성
openssl rand -base64 32
```

```yaml
stringData:
  WAKAPI_PASSWORD_SALT: "생성된-랜덤-문자열"
  WAKAPI_DB_PASSWORD: "안전한-비밀번호"
```

### 3. 배포

```bash
git add wakapi/ apps/wakapi.yml
git commit -m "feat(wakapi): add time tracking service"
git push
```

## 접속

- URL: https://wakapi.limtaehyun.dev
- 첫 방문시 회원가입 후 사용

## WakaTime 클라이언트 설정

`~/.wakatime.cfg`:
```ini
[settings]
api_url = https://wakapi.limtaehyun.dev/api
api_key = your-wakapi-api-key
```

API Key는 웹 UI의 Settings에서 확인 가능합니다.

## 추가 설정

필요한 경우 `deployment.yml`의 `env` 섹션에 환경변수 추가:

```yaml
# 회원가입 허용
- name: WAKAPI_ALLOW_SIGNUP
  value: "true"

# 메트릭 노출
- name: WAKAPI_EXPOSE_METRICS
  value: "true"
```

전체 환경변수: https://github.com/muety/wakapi#-configuration-options

## 문제 해결

로그 확인:
```bash
kubectl logs -n wakapi -l app=wakapi -f
```

Pod 상태 확인:
```bash
kubectl get pods -n wakapi
kubectl describe pod -n wakapi -l app=wakapi
```
