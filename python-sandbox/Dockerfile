# Prepare image to run Vaultize servers.
# Installs basic OS tools, python, python packages etc.
#
# Author: Akash Shende <akash@anoosmar.com>
# Date  : 16th March, 2015
#

# use CentOS 7 as base image - CentOS 7 has Systemd issues
# This downloads CentOS-7 image from docker-hub. It takes some time.

FROM vaultize/base:15.x
MAINTAINER  Akash Shende <akash@anoosmar.com>

# update YUM repo (Optional)

RUN groupadd -r web &&\
    useradd -r -g web web

ADD server server
WORKDIR "/server"
RUN "./install.sh"

#VOLUME ["/opt/config", "/var/log/uwsgi", "/var/run/uwsgi", "/home/web"]



