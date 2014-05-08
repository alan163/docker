#!/bin/bash
#git clone https://github.com/alan163/docker.git
#cd docker

wget http://tao.wang.in/www.tar.gz 
tar zxf www.tar.gz 
rm www.tar.gz

vagrant up
bin/dev update
bin/dev start
