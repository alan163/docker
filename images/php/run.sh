#!/bin/bash
docker_dir="/docker/images/php"
cp $docker_dir/conf/php.ini /php/etc/
cp $docker_dir/conf/php-fpm.conf /php/etc/
cp $docker_dir/conf/nginx/* /nginx/conf/
/php/sbin/php-fpm
/nginx/sbin/nginx
tail -f /nginx/log/*
