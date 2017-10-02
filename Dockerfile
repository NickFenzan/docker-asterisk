FROM centos
RUN yum -y update && yum -y install \
  gcc \
  gcc-c++ \
  libtool-ltdl-devel \
  libuuid-devel \
  libxml2-devel \
  make \
  ncurses-devel \
  sqlite-devel \
  unixODBC-devel \
  wget

RUN mkdir /usr/local/src/jansson
WORKDIR /usr/local/src/jansson
RUN wget http://www.digip.org/jansson/releases/jansson-2.10.tar.gz
RUN tar -zxvf jansson-2.10.tar.gz --strip=1
RUN ./configure -prefix=/usr/ &&  make clean && make && make install && ldconfig
RUN mkdir /usr/local/src/asterisk
WORKDIR /usr/local/src/asterisk
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-14-current.tar.gz
RUN tar -zxvf asterisk-14-current.tar.gz --strip=1
RUN ./configure && make && make install
WORKDIR /
RUN rm -rf /usr/local/src/*
