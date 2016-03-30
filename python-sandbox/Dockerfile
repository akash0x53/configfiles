# Prepare image with python packages installed.
# Installs necessary python packages etc.
#
# Author: Akash Shende <akash@anoosmar.com>
# Date  : 16th March, 2015
#

# use vaultize/base:15.x or latest, vaultize/base has all required library installed 
# in it. So use it.

FROM vaultize/base:15.x
MAINTAINER  Akash Shende <akash@anoosmar.com>

RUN groupadd -r web &&\
    useradd -r -g web web

COPY server server
WORKDIR "/server"
RUN "./install.sh"
