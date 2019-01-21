#!/bin/sh
SOURCE="$0"

while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
cd $DIR

mkdir /data/www -p
mkdir /data/log/nginx -p
mkdir /data/mysql -p

cp -r ./conf /data

echo "Done!"
