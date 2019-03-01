FROM nginx:alpine

ENV TIMEZONE    Asia/Shanghai

COPY nginx.conf /etc/nginx/nginx.conf

RUN /sbin/ip route|awk '/default/ {print $3,"\tdockerhost"}' >> /etc/hosts