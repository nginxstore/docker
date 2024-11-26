#!/bin/sh

DEFAULT_HTTP_PORT=80
LISTEN_PORT_HTTP=${LISTEN_PORT_HTTP:-$DEFAULT_HTTP_PORT}

if [ -z "$TARGET_SERVERS_HTTP" ]; then
    echo "ERROR: TARGET_SERVERS_HTTP 환경 변수를 설정해야 합니다."
    exit 1
fi

# HTTP 서버 목록 생성
UPSTREAM_HTTP_SERVERS=""
for SERVER in $(echo "$TARGET_SERVERS_HTTP" | tr ',' '\n'); do
    UPSTREAM_HTTP_SERVERS="${UPSTREAM_HTTP_SERVERS}server $SERVER;\n"
done

# default.conf 템플릿에서 치환
sed -e "s|{{HTTP_SERVERS}}|$UPSTREAM_HTTP_SERVERS|g" \
    -e "s|{{LISTEN_PORT_HTTP}}|$LISTEN_PORT_HTTP|g" \
    /tmp/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"
