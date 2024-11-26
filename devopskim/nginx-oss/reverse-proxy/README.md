
# NGINX 기반 Docker 리버스 프록시

이 프로젝트는 Docker를 사용하여 NGINX 기반 리버스 프록시를 설정하고 사용할 수 있도록 설계되었습니다. HTTP/HTTPS 요청을 동적으로 설정된 백엔드 서버로 전달하며, 간단한 설정으로 다양한 환경에 적응할 수 있습니다.

## 주요 기능

- **리버스 프록시**: 클라이언트 요청을 백엔드 서버로 전달하며, 부하 분산 및 보안을 지원.
- **동적 구성**: 환경 변수로 백엔드 서버, 포트, 프로토콜을 간편하게 설정.
- **경량화된 Docker 이미지**: NGINX Alpine 이미지를 기반으로 구축.

---

## 사용 방법

### 1. **Docker 이미지 빌드**
```
docker build -t nginx-reverse-proxy .
```

### 2. **컨테이너 실행**
```bash
docker run -d --name nginx-reverse-proxy \
-p 8080:80 \
-e PROTOCOL="http" \
-e PROXY_TARGET_SERVER="192.168.1.101:8080" \
-e LISTEN_PORT_HTTP=80 \
nginx-reverse-proxy
```

### 3. **구성 확인**
컨테이너 내부에서 생성된 NGINX 설정 파일을 확인합니다.
```bash
docker exec -it nginx-reverse-proxy cat /etc/nginx/conf.d/default.conf
```


## 환경 변수

| 변수명                  | 설명                                      | 기본값       |
|-------------------------|-------------------------------------------|--------------|
| `PROTOCOL`              | 프록시 요청에 사용할 프로토콜 (http/https)   | 필수 설정    |
| `PROXY_TARGET_SERVER`   | 리버스 프록시가 연결할 백엔드 서버 주소   | 필수 설정    |
| `LISTEN_PORT_HTTP`      | 	리버스 프록시가 수신할 포트               | 80           |


## 프로젝트 구조

```plaintext
.
├── Dockerfile              # 리버스 프록시용 Dockerfile
├── entrypoint.sh           # 설정 파일을 동적으로 생성하는 스크립트
└── default.conf.template   # 리버스 프록시용 NGINX 템플릿 파일
```


## 라이선스

이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.
