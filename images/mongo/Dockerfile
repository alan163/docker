FROM centos:centos6
MAINTAINER wangtao <tao.wang@funplus.com>

#ssh-server install
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo 'root:123456' | chpasswd
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&  sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# python
RUN yum install -y python-setuptools wget tar
RUN easy_install pip

#supervisor
RUN pip install supervisor

ENV VERSION 2.2.0
RUN wget http://docker.repo.in:8000/src/mongodb-linux-x86_64-$VERSION.tgz
RUN tar xzvf mongodb-linux-x86_64-$VERSION.tgz
RUN ln -sfn mongodb-linux-x86_64-$VERSION mongodb

RUN mkdir /data
RUN mkdir /logs

ADD rs-initiate.sh /rs-initiate.sh
ADD supervisord.conf /supervisord.conf
ADD run.sh /run.sh

VOLUME [ "/logs" ]
VOLUME [ "/data" ]

EXPOSE 22
EXPOSE 27017
EXPOSE 28017

CMD ["/run.sh"]
