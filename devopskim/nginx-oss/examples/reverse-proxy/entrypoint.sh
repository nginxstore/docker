#!/bin/sh

# 기본값 설정
DEFAULT_HTTP_PORT=80
LISTEN_PORT_HTTP=${LISTEN_PORT_HTTP:-$DEFAULT_HTTP_PORT}

# 환경 변수 확인
if [ -z "$PROTOCOL" ]; then
    echo "ERROR: PROTOCOL 환경 변수를 설정해야 합니다."
    exit 1
fi

if [ -z "$PROXY_TARGET_SERVER" ]; then
    echo "ERROR: PROXY_TARGET_SERVER 환경 변수를 설정해야 합니다."
    exit 1
fi

# default.conf 템플릿에서 치환
sed -e "s|{{PROTOCOL}}|$PROTOCOL|g" \
    -e "s|{{PROXY_TARGET_SERVER}}|$PROXY_TARGET_SERVER|g" \
    -e "s|{{LISTEN_PORT_HTTP}}|$LISTEN_PORT_HTTP|g" \
    /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# NGINX 실행
exec "$@"
