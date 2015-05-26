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
RUN yum -y update &&\
	yum groupinstall -y "Development tools" &&\
	yum -y install vim\
		 sudo\
		 ntp\
		 wget\
		 htop\
		 iotop\
		 iftop\
		 ibmonitor\
		 lsof\
		 mt-st\
		 system-config-network-tui\
		 openssl-devel*\
		 zlib-*\
		 memtester\
		 numactl\
		 monit\
		 ssmtp\
		 sysstat\
		 cifs-utils\
		 xfsprog\
		 ntfs-3g\
		 libxml2-devel\
		 libxslt-devel\
		 openldap\
		 openldap-devel\
		 libjpeg-devel\
		 giflib-devel\
		 freetype-devel\
		 swftools\
		 ImageMagick\
		 xpdf \
		 libedit\
		 libedit-devel\
		 libgssapi\
		 pam-devel\
		 libsmbclient\
		 python-devel
