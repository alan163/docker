#!/bin/bash
docker_dir="/docker/images/mysql"
cp $docker_dir/my.cnf /mysql/
cd /mysql &&  /mysql/bin/mysqld_safe --defaults-file=/mysql/my.cnf&
/usr/sbin/sshd -D
