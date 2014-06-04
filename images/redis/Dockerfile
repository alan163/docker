FROM centos:centos6
MAINTAINER wangtao <tao.wang@funplus.com>

#ssh-server install
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo 'root:123456' | chpasswd
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&  sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ENV VERSION 2.4.16
RUN yum -y install gcc gcc-c++ wget tar
RUN wget http://redis.googlecode.com/files/redis-$VERSION.tar.gz
RUN tar xzf redis-$VERSION.tar.gz
RUN cd redis-$VERSION && make
RUN ln -sfn redis-$VERSION redis
RUN mkdir /data
RUN mkdir /logs
ADD run.sh /run.sh

EXPOSE 22
EXPOSE 6379

CMD ["/run.sh"] 
