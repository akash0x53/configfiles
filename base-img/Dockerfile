#
# Prepare image to run Vaultize servers.
# Installs basic OS tools, python, python packages etc.
#
# Author: Akash Shende <akash@anoosmar.com>
# Date  : 16th March, 2015
#

# use CentOS 7 as base image.
# This downloads CentOS-7 image from docker-hub. It takes some time.
FROM centos:7
MAINTAINER  Akash Shende <akash@anoosmar.com>

# update YUM repo (Optional)
RUN yum update

# install essential development tools
RUN yum groupinstall -y "Development tools"
RUN yum install -y vim sudo ntp wget

# Essential monitoring tools
RUN yum install -y htop iotop iftop ibmonitor lsof

RUN yum install -y mt-st system-config-network-tui

# Install OpenSSL libs
RUN yum install -y openssl-devel* zlib-*

# System tools
RUN yum install memtester numactl monit ssmtp sysstat cifs-utils xfsprog ntfs-3g

# Essential libs
RUN yum -y libxml2-devel libxslt-devel openldap openldap-devel

# Important Libraries for Office server & passthru service.
RUN yum -y install libjpeg-devel giflib-devel freetype-devel
RUN yum -y install swftools
RUN yum -y install ImageMagick
RUN yum -y install xpdf

RUN yum -y install libedit libedit-devel libgssapi pam-devel # required by OpenSSH 6.x
RUN yum -y install libsmbclient
RUN yum -y upgrade libsmbclient
