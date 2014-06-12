#/bin/bash
set -e
PHP_VERSION=5.3.5
NGINX_VERSION=0.8.55

#groupadd  work && useradd work -m -s /bin/bash -d /home/work -g work
#rpm -Uvh http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm
#echo 'work:123456' | chpasswd
#yum -y install gcc pcre pcre-devel gcc-c++ autoconf libxml2 libxml2-devel zlib zlib-devel glibc libjpeg libjpeg-devel libpng libpng-devel glibc-devel glib2 glib2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers libxml2-devel libxslt-devel   gd openssh-clients mysql-devel GeoIP GeoIP-devel vi vim perl-devel gd-devel
su work - && cd /home/work/

wget http://fantasymobile-test1.socialgamenet.com/src/nginx-${NGINX_VERSION}.tar.gz && \
tar zxf nginx-${NGINX_VERSION}.tar.gz && \
cd nginx-${NGINX_VERSION} &&  \
./configure --prefix=/home/work/webserver/  --error-log-path=/home/work/logs/error.log --http-log-path=/home/work/logs/access.log --http-client-body-temp-path=/home/work/webserver/tmp/client_body --http-proxy-temp-path=/home/work/webserver/tmp/proxy --http-fastcgi-temp-path=/home/work/webserver/tmp/fastcgi --http-uwsgi-temp-path=/home/work/webserver/tmp/uwsgi --http-scgi-temp-path=/home/work/webserver/tmp/scgi --pid-path=/home/work/var/nginx.pid --lock-path=//home/work/var/nginx.lock --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-file-aio --with-mail_ssl_module --with-ipv6 && \
make && make install

wget http://fantasymobile-test1.socialgamenet.com/src/php-${PHP_VERSION}.tar.gz && \
tar zxf php-${PHP_VERSION}.tar.gz && \
cd php-${PHP_VERSION} && \
./configure --prefix=/home/work/php --sbindir=/home/work/php/sbin --with-config-file-path=/home/work/php/etc --with-config-file-scan-dir=/home/work/php/etc/php.d --enable-fpm --enable-mbstring --without-pear --with-libdir=lib64 --with-curl --with-openssl  --with-zlib   --with-mysql=shared,mysqlnd  --enable-pcntl --with-pdo-mysql && \
make && make install

mkdir -p /home/work/webroot /home/work/app /home/work/conf /home/work/data /home/work/webserver/tmp

#清理环境
echo 'export PATH=$PATH:/home/work/php/bin/'>/home/work/.bashrc
wget --no-check-certificate https://raw.githubusercontent.com/alan163/docker/master/images/php/conf.tar.gz && tar zxf conf.tar.gz
#wget --no-check-certificate https://raw.githubusercontent.com/alan163/docker/master/images/php/run.sh && chmod +x run.sh

rm  /home/work/*.tar.gz && rm -rf /home/work/php-$PHP_VERSION /home/work/nginx-$NGINX_VERSION
chown work:work -R /home/work

#memcache扩展
wget http://pecl.php.net/get/memcache-2.2.7.tgz
tar zvf memcache-2.27.tar.gz && cd memcache-2.27 && ./configure --enable-memcache --with-php-config=/home/work/php/bin/php-config --with-zlib-dir  && make && make install 
#memcached
yum install libmemcached -y
wget http://pecl.php.net/get/memcached-2.1.0.tgz
tar zxvf memcached-2.1.0.tgz && cd memcached-2.1.0 &&  ~/php/bin/phpize && ./configure  --with-php-config=/home/work/php/bin/php-config 
#mogno扩展
wget http://pecl.php.net/get/mongo-1.3.7.tgz
tar zxf mongo-1.3.7.tgz && cd mongo-1.3.7  &&  ~/php/bin/phpize  && ./configure  --with-php-config=/home/work/php/bin/php-config  && make && make install 
#msgpack
wget http://pecl.php.net/get/msgpack-0.5.5.tgz
tar zxf msgpack-0.5.5.tgz && cd msgpack-0.5.5 &&  ~/php/bin/phpize  && ./configure  --with-php-config=/home/work/php/bin/php-config  && make && make install 
#redis
wget http://pecl.php.net/get/redis-2.2.3.tgz
tar zxf redis-2.2.3.tgz && cd redis-2.2.3 &&   ~/php/bin/phpize  && ./configure  --with-php-config=/home/work/php/bin/php-config  && make && make install 
#eacc wget https://github.com/downloads/eaccelerator/eaccelerator/eaccelerator-0.9.6.1.tar.bz2 
tar jxvf eaccelerator-0.9.6.tar.bz2 && cd eaccelerator-0.9.6.1  &&   ~/php/bin/phpize  && ./configure  --with-php-config=/home/work/php/bin/php-config  && make && make install 
