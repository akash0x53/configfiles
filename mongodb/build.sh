#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Missing tag name"
	exit 1
fi

tag=$1
repo="vaultize"
shift

if [ ! -d mongodb-1* ]; then
	echo "MongoDB Not Found in Current Directory."\
		"Download mongodb and extract here and run this script"
	exit 1
fi
docker build --force-rm=true -t $repo:$tag .
