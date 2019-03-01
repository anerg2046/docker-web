#!/bin/sh
SOURCE="$0"
COMMAND="$1"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

echo -n 'HOST_IP='ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+' > .env
ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+' >> .env

cd $DIR
if [ "$COMMAND" == "start" ]; then
    docker-compose -p web up -d
elif [ "$COMMAND" == "stop" ]; then
    docker-compose -p web stop
elif [ "$COMMAND" == "build" ]; then
    docker-compose -p web stop
    docker-compose -p web up --build -d
    docker rmi $(docker images | grep "none" | awk '{print $3}')
else
    echo "useage: docker-web start|stop|build"
fi