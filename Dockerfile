FROM ruby:2.3.3
#FROM heroku/heroku:16

MAINTAINER Colibri Software <support@colibri-software.com>

ENV FREETDS_VERSION freetds-1.00.49
ENV TDSVER 7.3

# Allow secure transport
RUN apt-get update && apt-get install -y apt-transport-https

# Add Heroku repository and key
RUN echo "deb https://cli-assets.heroku.com/branches/stable/apt ./" > \
    /etc/apt/sources.list.d/heroku.list
RUN wget -qO- https://cli-assets.heroku.com/apt/release.key | apt-key add -

# Install Heroku CLI, MySQL client, and FreeTDS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    heroku \
    libc6-dev \
    mysql-client-5.5
    #mysql-client-5.7 \
    #mysql-client-core-5.7

# Install FreeTDS
RUN curl -s ftp://ftp.freetds.org/pub/freetds/stable/$FREETDS_VERSION.tar.gz \
    | tar xz -C /tmp
WORKDIR /tmp/$FREETDS_VERSION
RUN ./configure --with-tdsver=$TDSVER --enable-msdblib
RUN make
RUN make install
WORKDIR /
RUN rm -rf /tmp/$FREETDS_VERSION
