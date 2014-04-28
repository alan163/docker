#/bin/bash
#set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
APPS=${APPS:-/home/vagrant/apps}
SCRIPT_HOME=$(dirname $DIR)
REGISTRY="docker.repo:8001/"

. $SCRIPT_HOME/bin/init.sh

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
        -v $APPS/php/logs:/mnt/htdocs/logs \
        -v ~/www:/code/ \
        -v $SCRIPT_HOME:/docker \
        --name php \
        ${REGISTRY}funplus/php \
        sh /run.sh)
    echo "Started PHP in container $PHP"

    sudo mkdir -p $APPS/mysql/logs
    sudo mkdir -p $APPS/mysql/data
    #sudo chown mysql:mysql -R $APPS/mysql
    sudo docker rm mysql > /dev/null 2>&1

    # init mysql for 
    #init_mysql

    MYSQL=$(docker run \
        -d \
        -p 3306:3306 \
        -v $APPS/mysql/logs:/logs \
        -v $APPS/mysql/data:/data \
        -v $SCRIPT_HOME:/docker \
        --name mysql \
        ${REGISTRY}funplus/mysql \
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
        ${REGISTRY}funplus/redis \
        sh /run.sh)
    echo "Started REDIS in container $REDIS"


    sudo docker rm memcached > /dev/null 2>&1

    MEMCACHED=$(docker run \
        -d \
        -p 11211:11211 \
        -v $SCRIPT_HOME:/docker \
        --name memcached \
        ${REGISTRY}funplus/memcached)
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
        ${REGISTRY}funplus/mongo /usr/local/bin/supervisord -c /supervisord.conf -n)
    echo "Started MONGO in container $MONGO"

}

update(){
    #apt-get update
    #apt-get install -y lxc-docker

    docker pull ${REGISTRY}funplus/redis
    docker pull ${REGISTRY}funplus/mongo
    docker pull ${REGISTRY}funplus/php
    docker pull ${REGISTRY}funplus/mysql
    docker pull ${REGISTRY}funplus/memcached
}

fix_registry_ip() {
    . $SCRIPT_HOME/etc/registry.conf
    sudo sed -i -e "s/.*docker.repo/$DOCKER_REG_IP docker.repo/g" /etc/hosts
    sleep 1
}

init_mysql() {
    docker run \
        -d \
        -p 3306:3306 \
        -v $APPS/mysql/logs:/logs \
        -v $APPS/mysql/data:/data \
        -v $SCRIPT_HOME:/docker \
        ${REGISTRY}funplus/mysql \
        /mysql/bin/mysql_install_db --user=mysql --ldata=/data
}

case "$1" in
    restart)
        killz
        fix_registry_ip
        start
        ;;
    start)
        fix_registry_ip
        start
        ;;
    stop)
        stop
        ;;
    kill)
        killz
        ;;
    update)
        update_code
        ;;
    update_all)
        update
        update_code
        ;;
    status)
        docker ps
        ;;
    *)
        echo $"Usage: $0 {start|stop|kill|update|restart|status|ssh}"
        RETVAL=1
esac
