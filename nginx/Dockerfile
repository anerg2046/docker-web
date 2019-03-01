FROM nginx:alpine

ENV TIMEZONE    Asia/Shanghai

COPY nginx.conf /etc/nginx/nginx.conf
COPY dockerhost.sh /usr/local/bin/dockerhost.sh

RUN chmod +x /usr/local/bin/dockerhost.sh \
    /usr/local/bin/dockerhost.sh