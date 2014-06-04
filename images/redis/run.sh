#!/bin/bash
docker_dir="/docker/images/redis"
cp $docker_dir/redis.conf /redis/
/usr/sbin/sshd
redis/src/redis-server /redis/redis.conf
