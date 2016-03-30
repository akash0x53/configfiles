

#Mongodb dockerization

FROM	centos:6
MAINTAINER	Akash Shende <akash@anoosmar.com>

# where db resides
RUN mkdir -p /data/db

# copy mongo*.tar.gz from host machine to container
COPY mongodb-* /opt/mongodb/

# /data/db:         Volume stores keep db on host machine
# /opt/config:      Read mongodb settings from here.
# /var/log/mongodb: Keep mongodb logs on host machine too.

VOLUME ["/data/db/", "/opt/config/", "/var/log/mongodb/"]

EXPOSE 27017

ENTRYPOINT /opt/mongodb/bin/mongod
CMD ["--config /opt/config/mongodb.conf"]
