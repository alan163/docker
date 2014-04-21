FROM docker-repo/funplus/ubuntu

RUN apt-get update

ENV VERSION 2.4.16
RUN wget http://redis.googlecode.com/files/redis-$VERSION.tar.gz
RUN tar xzf redis-$VERSION.tar.gz
RUN cd redis-$VERSION && make
RUN ln -sfn redis-$VERSION redis
RUN mkdir /data
RUN mkdir /logs

VOLUME [ "/logs" ]
VOLUME [ "/data" ]

ADD redis.conf redis.conf

EXPOSE 6379

CMD ["redis/src/redis-server", "redis.conf"] 
