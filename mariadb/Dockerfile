FROM alpine:3.8

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

COPY my.cnf /etc/mysql/my.cnf
COPY mariadb_run.sh /usr/local/bin/mariadb_run.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && apk -U upgrade \
  && apk add --update --no-cache mariadb mariadb-client \
  && rm -rf /tmp/* /var/cache/apk/* \
  && chmod 664 /etc/mysql/my.cnf \
  && chmod +x /usr/local/bin/mariadb_run.sh \
  && mkdir -p /run/mysqld

CMD ["/usr/local/bin/mariadb_run.sh"]