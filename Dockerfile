############################################################
# Dockerfile to build OpenProject container images
# Build procedure adapted from https://www.openproject.org
# Based on daedalus/baseimage
############################################################ 
# Set the base image to daedalus/baseimage
FROM phusion/baseimage:latest

# File Author / Maintainer
MAINTAINER Jonathan Temlett - Daedalus Solutions (jono@daedalus.co.za)

# prep
RUN groupadd openproject
RUN useradd --create-home --gid openproject openproject
RUN passwd openproject dearx@dm1n

#update apt-get
RUN apt-get update -y

# Install required packages
RUN apt-get install -y zlib1g-dev build-essential \
                    libssl-dev libreadline-dev            \
                    libyaml-dev libgdbm-dev               \
                    libncurses5-dev automake              \
                    libtool bison libffi-dev git curl     \
                    libxml2 libxml2-dev libxslt1-dev # nokogiri
                    
# Install Memcached
RUN apt-get install -y memcached

# Install MySQL
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server libmysqlclient-dev
# must run mysqladmin -u root password mysecretpasswordgoeshere

# configure Mysql
RUN mysql -uroot -p
RUN CREATE DATABASE openproject CHARACTER SET utf8;
RUN CREATE USER 'openproject'@'localhost' IDENTIFIED BY '';
RUN GRANT ALL PRIVILEGES ON openproject.* TO 'openproject'@'localhost';
RUN FLUSH PRIVILEGES;
RUN QUIT


# Install wget
RUN apt-get install -y wget

# Install OpenProject Core
RUN wget -qO - https://deb.packager.io/key | sudo apt-key add -
RUN echo "deb https://deb.packager.io/gh/opf/openproject trusty stable/4.2" | sudo tee /etc/apt/sources.list.d/openproject.list
RUN sudo apt-get update
RUN sudo apt-get install -y openproject

# Install OpenProject Community
RUN wget -qO - https://deb.packager.io/key | sudo apt-key add -
RUN echo "deb https://deb.packager.io/gh/finnlabs/pkgr-openproject-community trusty stable/4.2" | sudo tee /etc/apt/sources.list.d/pkgr-openproject-community.list
RUN apt-get update
RUN open 
