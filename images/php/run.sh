#!/bin/bash
docker_dir="/docker/images/php"
cp -rf $docker_dir/conf/* /home/work/
/home/work/php/sbin/php-fpm
/home/work/webserver/sbin/nginx
