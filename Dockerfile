FROM ubuntu:17.04

MAINTAINER DarrolMusambani <d.mrugalla@gmail.com>

RUN apt-get update
RUN apt-get -y --force-yes install wget apt-transport-https

# Install perl packages
RUN apt-get -y --force-yes install libalgorithm-merge-perl \
libclass-isa-perl \
libcommon-sense-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libio-socket-ip-perl \
libio-socket-multicast-perl \
libjson-perl \
libjson-xs-perl \
libmail-sendmail-perl \
libsocket-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl \
libxml-simple-perl \
libdbd-pg-perl \
libdevice-serialport-perl \
libcgi-pm-perl \
sqlite3 \
libdbd-sqlite3-perl \
libtext-diff-perl \
libdbi-perl


RUN wget http://fhem.de/fhem-5.8.deb
RUN dpkg -i fhem-5.8.deb
RUN apt-get -y --force-yes install supervisor telnet postgresql-client 
RUN mkdir -p /var/log/supervisor

RUN echo Europe/Berlin > /etc/timezone && dpkg-reconfigure tzdata

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/opt/fhem"]
EXPOSE 8083

CMD ["/usr/bin/supervisord"]