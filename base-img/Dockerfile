#
# Prepare image to run Vaultize servers.
# Installs basic OS tools, python, python packages etc.
#
# Author: Akash Shende <akash@anoosmar.com>
# Date  : 16th March, 2015
#

# use CentOS 7 as base image - CentOS 7 has Systemd issues
# This downloads CentOS-7 image from docker-hub. It takes some time.

FROM centos:7
MAINTAINER  Akash Shende <akash@anoosmar.com>

# update YUM repo (Optional)
RUN yum -y update &&\
	yum -y install epel-release &&\
	yum -y update &&\
	yum groupinstall -y "Development tools" &&\
	yum -y install openssh-clients\
		vim-enhanced\
		ntp\
		wget\
		openssl-devel*\
		zlib-*\
		system-config-network-tui\
		system-config-keyboard\
		mt-st\
		ibmonitor\
		memtester\
		numactl\
		sysstat\
		cifs-utils\
		xfsprogs\
		libxml2-devel\
		libxslt-devel\
		libyaml\
		libyaml-devel\
		ntfs-3g\
		ntfsprogs\
		openldap\
		openldap-devel\
		zlib-devel\
		libjpeg-turbo-devel\
		giflib-devel\
		freetype-devel\
		swftools\
		libsmbclient\
		ssmtp\
		unzip\
		tar\
		tmpwatch\
		python-devel\
		python-pip\
		gdisk\
		pcre*\
		ImageMagick\
		xpdf

RUN groupadd -r web &&\
    useradd -r -m -g web web &&\
