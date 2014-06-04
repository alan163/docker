FROM centos:centos6
MAINTAINER wangtao <tao.wang@funplus.com>

ENV VERSION 1.4.5

#ssh-server install
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo 'root:123456' | chpasswd
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&  sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

RUN yum -y install gcc gcc-c++ wget tar

RUN wget http://docker.repo.in:8000/src/libevent-2.0.21-stable.tar.gz && \
    tar zxf libevent-2.0.21-stable.tar.gz && \
    cd libevent-2.0.21-stable && \
    ./configure --prefix=/usr && make && make install

RUN wget http://docker.repo.in:8000/src/memcached-$VERSION.tar.gz && \
        tar xzf memcached-$VERSION.tar.gz && \
        cd memcached-$VERSION && ./configure --with-libevent=/usr --prefix=/memcached && \
        make && make install
RUN ln -s /usr/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5

EXPOSE 11211
EXPOSE 22

CMD ["/memcached/bin/memcached", "-u", "root"]
