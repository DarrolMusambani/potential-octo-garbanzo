FROM ubuntu:16.04

MAINTAINER DarrolMusambani <d.mrugalla@gmail.com>

ENV TZ 'Europe/Berlin'

# Install Main Packages
RUN apt-get update
RUN apt-get -y --force-yes install wget  \
apt-transport-https  \
mosquitto-clients \
telnet \
postgresql-client \
nano \
build-essential \
cifs-utils \
smbclient \
keyutils \
openssh-server \
cpanminus \
bluetooth \
bluez-hcidump \
bluez \
blueman

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
libdbi-perl \
libcrypt-rijndael-perl \
#Add. Packages for GoogleAuthenticator
libconvert-base32-perl \
libauthen-oath-perl \
libcrypt-urandom-perl

RUN cpanm Net::MQTT::Simple
RUN cpanm Net::MQTT::Constants
RUN cpanm Text::Unidecode
RUN cpanm Net::Telnet
RUN cpanm SOAP::Lite

# Set the locale
RUN apt-get install -y locales locales-all
RUN locale-gen de_DE.UTF-8 
ENV LANG de_DE.UTF-8 
ENV LANGUAGE de_DE:de  
ENV LC_ALL de_DE.UTF-8  

#Set timezone
RUN echo $TZ > /etc/timezone && \
    apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN wget http://fhem.de/fhem-5.8.deb
RUN dpkg -i fhem-5.8.deb

#Cleaning up
RUN apt-get clean && apt-get autoremove
RUN rm /fhem-5.8.deb

COPY initContainer.sh wrapper.sh
VOLUME ["/opt/fhem"]

EXPOSE 8083
EXPOSE 8084
EXPOSE 7072

CMD ./wrapper.sh
