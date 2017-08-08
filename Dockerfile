FROM ruby:2.3.3
#FROM heroku/heroku:16

MAINTAINER Colibri Software <support@colibri-software.com>

ENV FREETDS_VERSION freetds-1.00.49
ENV TDSVER 7.3

# Install TDS
RUN apt-get update && apt-get install -y build-essential libc6-dev
RUN curl -s ftp://ftp.freetds.org/pub/freetds/stable/$FREETDS_VERSION.tar.gz | tar xz -C /tmp
WORKDIR /tmp/$FREETDS_VERSION
RUN ./configure --with-tdsver=$TDSVER --enable-msdblib
RUN make
RUN make install

# Install Heroku CLI
RUN wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install MySQL client
RUN apt-get update && apt-get install -y mysql-client-5.5
#RUN apt-get update && apt-get install -y mysql-client-5.7 mysql-client-core-5.7

WORKDIR /
RUN rm -rf /tmp/$FREETDS_VERSION
