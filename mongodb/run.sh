#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: run.sh <reponame> <tag>"
	exit 1
fi

repo=$1
tag=$2

if [ ! -d /data/db ]; then
	echo "ERR: /data/db not present, please check and re-run"
	exit 1
fi

if [ ! -f /opt/config/mongodb.conf ]; then
	echo "WARN: /opt/config/mongodb.conf missing"
fi

docker run -d\
	   -v /data/db:/data/db\
	   -v /opt/config:/opt/config\
	   -v /var/log/mongodb:/var/log/mongodb\
	   -p 27017:27017\
	   --name vaultize_mongodb\
	      $repo:$tag
