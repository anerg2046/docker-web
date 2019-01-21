#!/bin/sh
set -e

if [ ! -f "/var/lib/mysql/ibdata1" ]; then
        echo "installing database skeleton"
	mysql_install_db --rpm --skip-networking > /dev/null 
	chown -R mysql.mysql /var/lib/mysql /run/mysqld
fi

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"@NErG360113"}
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
MYSQLD_ARGS=${MYSQLD_ARGS:-""}

tfile=`mktemp`
if [[ ! -f "$tfile" ]]; then
    return 1
fi

cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
EOF

if [[ "$MYSQL_DATABASE" != "" ]]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [[ "$MYSQL_USER" != "" ]]; then
        echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
fi

/usr/bin/mysqld -u mysql --bootstrap --skip-networking $MYSQLD_ARGS < $tfile
rm -f $tfile

exec /usr/bin/mysqld -u mysql $MYSQLD_ARGS