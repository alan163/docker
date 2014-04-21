#!/bin/bash
docker_dir="/docker/images/redis"
cp $docker_dir/redis.conf /redis/
redis/src/redis-server /redis/redis.conf
