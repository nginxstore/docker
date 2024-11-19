#!/bin/sh

DEFAULT_STREAM_PORT=12345
LISTEN_PORT_STREAM=${LISTEN_PORT_STREAM:-$DEFAULT_STREAM_PORT}

if [ -z "$TARGET_SERVERS_STREAM" ]; then
    echo "ERROR: TARGET_SERVERS_STREAM 환경 변수를 설정해야 합니다."
    exit 1
fi

# 서버 목록 생성
UPSTREAM_STREAM_SERVERS=""
for SERVER in $(echo "$TARGET_SERVERS_STREAM" | tr ',' '\n'); do
    UPSTREAM_STREAM_SERVERS="${UPSTREAM_STREAM_SERVERS}server $SERVER;\n"
done

# nginx.conf 템플릿을 실제 값으로 치환
sed -e "s|{{STREAM_SERVERS}}|$UPSTREAM_STREAM_SERVERS|g" \
    -e "s|{{LISTEN_PORT_STREAM}}|$LISTEN_PORT_STREAM|g" \
    /etc/nginx/templates/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"
