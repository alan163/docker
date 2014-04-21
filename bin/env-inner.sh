#/bin/bash
#set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
APPS=${APPS:-/mnt/apps}
SCRIPT_HOME=$(dirname $DIR)

killz(){
    echo "Killing all docker containers:"
    docker ps
    ids=`docker ps | tail -n +2 |cut -d ' ' -f 1`
    if [ "$ids" != "" ]; then
        echo $ids | xargs docker kill
        echo $ids | xargs docker rm
    fi

}

stop(){
    echo "Stopping all docker containers:"
    docker ps
    ids=`docker ps | tail -n +2 |cut -d ' ' -f 1`
    if [ "$ids" = "" ]; then
        echo "already stoped!"
    else
        echo $ids | xargs docker stop
        echo $ids | xargs docker rm
    fi
}

start(){
    sudo mkdir -p $APPS/php/logs
    sudo mkdir -p $APPS/www/
    sudo docker rm php > /dev/null 2>&1
    PHP=$(docker run \
        -d \
        -p 80:80 \
        -v $APPS/php/logs:/nginx/log \
        -v $APPS/www:/code/ \
        -v $SCRIPT_HOME:/docker \
        --name php \
        funplus/php:bv \
        sh /run.sh)
    echo "Started PHP in container $PHP"

    sudo mkdir -p $APPS/mysql/logs
    sudo mkdir -p $APPS/mysql/data
    sudo chown mysql:mysql -R $APPS/mysql
    sudo docker rm mysql > /dev/null 2>&1

    MYSQL=$(docker run \
        -d \
        -p 3306:3306 \
        -v $APPS/mysql/logs:/logs \
        -v $APPS/mysql/data:/data \
        -v $SCRIPT_HOME:/docker \
        --name mysql \
        funplus/mysql:5.1.65 \
        sh /run.sh)
    echo "Started MYSQL in container $MYSQL"


    sudo mkdir -p $APPS/redis/data
    sudo mkdir -p $APPS/redis/logs
    sudo docker rm redis > /dev/null 2>&1

    REDIS=$(docker run \
        -d \
        -p 6379:6379 \
        -v $APPS/redis/data:/data \
        -v $SCRIPT_HOME:/docker \
        --name redis \
        funplus/redis:2.4.16 \
        sh /run.sh)
    echo "Started REDIS in container $REDIS"


    sudo docker rm memcached > /dev/null 2>&1

    MEMCACHED=$(docker run \
        -d \
        -p 11211:11211 \
        -v $SCRIPT_HOME:/docker \
        --name memcached \
        funplus/memcached:1.4.15)
    echo "Started MEMCACHED in container $MEMCACHED"


    mkdir -p $APPS/mongo/data
    mkdir -p $APPS/mongo/logs
    sudo docker rm mongo > /dev/null 2>&1
    # funplus/mongodb:test /usr/local/bin/supervisord -c /supervisord.conf -n)
        #funplus/mongo)
    MONGO=$(docker run \
        -p 27017:27017 \
        -p 28017:28017 \
        -v $APPS/mongo/data:/data \
        -v $APPS/mongo/logs:/logs \
        -d \
        --name mongo \
         funplus/mongodb:test /usr/local/bin/supervisord -c /supervisord.conf -n)
    echo "Started MONGO in container $MONGO"

    #sleep 1

}

update(){
    apt-get update
    apt-get install -y lxc-docker

    docker pull funplus/redis
    docker pull funplus/mongo
    docker pull shipyard/shipyard
}

case "$1" in
    restart)
        killz
        start
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    kill)
        killz
        ;;
    update)
        update
        ;;
    status)
        docker ps
        ;;
    *)
        echo $"Usage: $0 {start|stop|kill|update|restart|status|ssh}"
        RETVAL=1
esac
