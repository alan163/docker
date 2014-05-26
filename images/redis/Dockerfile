FROM centos:centos6
MAINTAINER wangtao <tao.wang@funplus.com>

ENV PHP_VERSION 0.8.55
ENV NGINX_VERSION 5.3.5

#user sys init
RUN groupadd  work && useradd work -m -s /bin/bash -d /home/work -g work
RUN yum install -y wget tar 
RUN wget http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -Uvh epel-release-6-8.noarch.rpm && rm epel-release-6-8.noarch.rpm

#ssh-server install 
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo ‘work:123456' | chpasswd&& echo ‘root:123456' | chpasswd
RUN mkdir -p /home/work/.ssh && chown work.work /home/work/.ssh && chmod 700 /home/work/.ssh
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&  sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

#lnmp 依赖基础库
RUN yum -y install gcc pcre pcre-devel gcc-c++ autoconf libxml2 libxml2-devel zlib zlib-devel glibc libjepg libjepg-devel libpng libpng-devel glibc-devel glib2 glib2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers libxml2-devel libxslt-devel   gd openssh-clients mysql-devel GeoIP GeoIP-devel vi vim perl-devel 
RUN ln -s /home/work/php/bin/php /usr/local/bin/php

#work 账号中正式安装
RUN su work

RUN wget http://docker.repo.in:8000/src/nginx-${NGINX_VERSION}.tar.gz
RUN tar zxf nginx-${NGINX_VERSION}.tar.gz
RUN cd nginx-${NGINX_VERSION}
RUN ./configure --prefix=/home/work/webserver/  --error-log-path=/home/work/log/error.log --http-log-path=/home/work/log/access.log --http-client-body-temp-path=/home/work/webserver/tmp/client_body --http-proxy-temp-path=/home/work/webserver/tmp/proxy --http-fastcgi-temp-path=/home/work/webserver/tmp/fastcgi --http-uwsgi-temp-path=/home/work/webserver/tmp/uwsgi --http-scgi-temp-path=/home/work/webserver/tmp/scgi --pid-path=/home/work/var/nginx.pid --lock-path=//home/work/var/nginx.lock --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module  --with-mail --with-file-aio --with-mail_ssl_module --with-ipv6 
RUN make && make install

RUN cd ~ && wget http://docker.repo.in:8000/src/php-${PHP_VERSION}.tar.gz
RUN tar zxf php-${PHP_VERSION}.tar.gz
RUN cd php-${PHP_VERSION}
RUN ./configure --prefix=/home/work/php --sbindir=/home/work/php/sbin --with-config-file-path=/home/work/php/etc --with-config-file-scan-dir=/home/work/php/etc/php.d --enable-fpm --enable-mbstring --without-pear --with-libdir=lib64 --with-curl --with-openssl  --with-zlib  
RUN make && make install 

RUN mkdir /home/work/webroot /home/work/app /home/work/conf /home/work/data
RUN cd ~ &&  wget http://docker.repo.in:8000/src/env.tar.gz && tar zxf env.tar.gz 

#清理环境
RUN rm  *.tar.gz && rm -rf php-$PHP_VERSION nginx-$NGINX_VERSION

EXPOSE 22

CMD ["/usr/sbin/sshd", ""] 
CMD ["/usr/sbin/sshd", "-D", "-e"]
