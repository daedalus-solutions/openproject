############################################################
# Dockerfile to build OpenProject container images
# Build procedure adapted from https://www.openproject.org
# Based on daedalus/baseimage
############################################################ 
# Set the base image to daedalus/baseimage
FROM phusion/baseimage:latest

# File Author / Maintainer
MAINTAINER Jonathan Temlett - Daedalus Solutions (jono@daedalus.co.za)

# Install OpenProject
RUN wget -qO - https://deb.packager.io/key | sudo apt-key add -
RUN echo "deb https://deb.packager.io/gh/opf/openproject trusty stable/4.2" | sudo tee /etc/apt/sources.list.d/openproject.list
RUN apt-get install openproject
