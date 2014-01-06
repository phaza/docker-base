# base - Base Image with supervisord

FROM ubuntu
MAINTAINER Peter Haza <peter.haza@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install supervisor

ADD locale /etc/default/locale
ADD supervisord.conf /etc/supervisor/supervisord.conf

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

CMD ["/usr/bin/supervisord"]
