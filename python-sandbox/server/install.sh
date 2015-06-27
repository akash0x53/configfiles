#!/bin/bash
#
# Author: Akash Shende <akash@anoosmar.com


for zp in *.zip;
       do
               unzip $zp
               rm -f $zp
       done

for gz in *.gz;
       do
               tar -zxf $gz
               rm -f $gz
       done

pushd setuptools*
python setup.py install
popd

rm -rf setuptools*

pushd uwsgi-*
make -j4 && cp ./uwsgi /usr/bin/uwsgi
popd
rm -rf uwsgi-*

for i in $(ls -d1 */)
do
    ARGS="install"
    if [ "$i" == "wsgilog-0.2/" ];then
	cp -rf  "/server/ez_setup.py" "/server/wsgilog-0.2/"
    fi

    if [ "$i" == "apsw-3.7.10-r1/" ];then
        ARGS="fetch --version=3.7.10 --all --missing-checksum-ok build --enable-all-extensions install"
    fi

    cd "/server/$i"

    python setup.py $ARGS

    if [ "$?" != 0 ];then
        echo "$i Package not installed. Please check for the package $i"
        exit
    else
        echo "$i" >> /root/pylog
    fi
done

