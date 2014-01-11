# base - Base Image with supervisord and sshd

FROM triangle/ubuntu-saucy
MAINTAINER Peter Haza <peter.haza@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -qq update
RUN mkdir /var/run/sshd
RUN apt-get -yqq install supervisor openssh-server vim

ADD locale /etc/default/locale
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf

ADD key.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys
RUN sed -i -e 's/^\(session\s\+required\s\+pam_loginuid.so$\)/#\1/' /etc/pam.d/sshd


RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

EXPOSE 22

CMD ["/usr/bin/supervisord"]
