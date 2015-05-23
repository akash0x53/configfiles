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
RUN yum update &&\
	yum groupinstall -y "Development tools" &&\
	yum install -y vim sudo ntp wget &&\
	yum install -y htop iotop iftop ibmonitor lsof &&\
	yum install -y mt-st system-config-network-tui &&\
	yum install -y openssl-devel* zlib-* &&\
	yum install memtester numactl monit ssmtp sysstat cifs-utils xfsprog ntfs-3g &&\
	yum -y libxml2-devel libxslt-devel openldap openldap-devel &&\
	yum -y install libjpeg-devel giflib-devel freetype-devel &&\
	yum -y install swftools &&\
	yum -y install ImageMagick &&\
	yum -y install xpdf&&\
	yum -y install libedit libedit-devel libgssapi pam-devel &&\ # required by OpenSSH 6.x
	yum -y install libsmbclient &&\
	yum -y upgrade libsmbclient &&\
