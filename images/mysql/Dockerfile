FROM centos:centos6
MAINTAINER wangtao <tao.wang@funplus.com>

#ssh-server install
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo 'root:123456' | chpasswd
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&  sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config


RUN yum -y install ncurses libaio gcc gcc-c++ perl ncurses-devel bison wget tar
RUN groupadd -r mysql && useradd -g mysql -s /sbin/nologin mysql
RUN wget http://docker.repo.in:8000/src/Percona-Server-5.1.60.tar.gz && \
    tar zxf Percona-Server-5.1.60.tar.gz && \
    cd Percona-Server-5.1.60 && \
    ./configure --enable-shared --with-server-suffix=-rel13.1 --without-embedded-server --without-bench --with-zlib-dir=bundled --with-big-tables --with-plugins=partition,archive,blackhole,csv,example,federated,innodb_plugin --enable-assembler --enable-local-infile --with-mysqld-user=mysql --with-unix-socket-path=/mysql/var/mysql.sock --with-pic --prefix=/mysql --with-extra-charsets=complex --with-ssl   --enable-thread-safe-client --enable-profiling --with-comment='Percona Server (GPL), 13.1, Revision 413' --with-readline && \
    make && make install && ./scripts/mysql_install_db --user=mysql --datadir=/mysql/data --basedir=/mysql

RUN mkdir -p /mysql/var /mysql/data /mysql/logs

#清理环境
ADD my.cnf /mysql/my.cnf
ADD run.sh /run.sh
RUN rm  /*.tar.gz && rm -rf Percona-Server-5.1.60
RUN chown -R mysql:mysql /mysql

EXPOSE 22
EXPOSE 3306

CMD ["/run.sh"]
