

#Mongodb dockerization

FROM	centos
MAINTAINER	Akash Shende <akash@anoosmar.com>

# where db resides
RUN mkdir -p /data/db

# copy mongo*.tar.gz from host machine to container
COPY mongodb-* /opt/mongodb/

EXPOSE 27017

CMD ["--port 27017 --dbpath /data/db --smallfiles"]

ENTRYPOINT /opt/mongodb/bin/mongod
