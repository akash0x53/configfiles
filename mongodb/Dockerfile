

#Mongodb dockerization

FROM	centos
MAINTAINER	Akash Shende <akash@anoosmar.com>

# where db resides
RUN mkdir -p /data/db

# Place to keep MongoDB binaries
RUN mkdir -p /opt/mongodb

# copy mongo*.tar.gz from host machine to container
COPY mongodb-* /opt/mongodb/

# change working dir
WORKDIR /opt/mongodb/

# this changes mongodb's annoying long name, keep it short /opt/mongodb/bin
WORKDIR /opt/mongodb

EXPOSE 27017

CMD ["--port 27017 --dbpath /data/db --smallfiles"]

ENTRYPOINT /opt/mongodb/bin/mongod
