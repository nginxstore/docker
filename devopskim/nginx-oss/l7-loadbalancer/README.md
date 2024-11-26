
# NGINX 기반 Docker 로드밸런서 (L7)

이 프로젝트는 Docker를 사용하여 NGINX 기반 Layer 7 (L7) 로드밸런서를 설정하고 사용할 수 있도록 설계되었습니다. HTTP/HTTPS 트래픽을 동적으로 설정된 백엔드 서버로 분산합니다.

## 주요 기능

- **L7 로드밸런서**: HTTP/HTTPS 트래픽을 백엔드 서버로 분산.
- **동적 구성**: 환경 변수로 백엔드 서버와 포트를 간편하게 설정.
- **경량화된 Docker 이미지**: NGINX Alpine 이미지를 기반으로 구축.


## 사용 방법

### 1. **Docker 이미지 빌드**
```bash
docker build -t nginx-l7-loadbalancer .
```

### 2. **컨테이너 실행**
```bash
docker run -d --name l7-nginx-lb \
-p 8080:8080 \
-e TARGET_SERVERS_HTTP="192.168.1.101:80,192.168.1.102:80" \
-e LISTEN_PORT_HTTP=8080  \
nginx-l7-loadbalancer
```

### 3. **구성 확인**
컨테이너 내부에서 생성된 NGINX 설정 파일을 확인합니다.
```bash
docker exec -it l7-nginx-lb cat /etc/nginx/conf.d/default.conf
```


## 환경 변수

| 변수명                  | 설명                                      | 기본값       |
|-------------------------|-------------------------------------------|--------------|
| `TARGET_SERVERS_HTTP`   | L7 로드밸런서 백엔드 서버 (IP:PORT 목록)   | 필수 설정    |
| `LISTEN_PORT_HTTP`      | L7 로드밸런서가 수신할 포트               | 80           |


## 프로젝트 구조

```plaintext
.
├── Dockerfile              # L7 로드밸런서용 Dockerfile
├── entrypoint.sh           # 설정 파일을 동적으로 생성하는 스크립트
└── default.conf.template   # L7용 NGINX 템플릿 파일
```


## 라이선스

이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.
