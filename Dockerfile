FROM ubuntu

MAINTAINER Bryan Dollery <bryan.dollery@gmail.com>

RUN apt-get -y update && \
    apt-get -y install curl libaio1 unzip rlwrap && \
    mkdir -p oracle && \
    cd oracle && \
    curl -LsSk https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip -o basic.zip && \
    curl -LsSk https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-sqlplus-linux.x64-19.6.0.0.0dbru.zip -o sqlplus.zip && \
    curl -LsSk https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-sdk-linux.x64-19.6.0.0.0dbru.zip -o sdk.zip && \
    curl -LsSk https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-jdbc-linux.x64-19.6.0.0.0dbru.zip -o jdbc.zip && \
    unzip basic.zip && \
    unzip sqlplus.zip && \
    unzip sdk.zip && \
    unzip jdbc.zip && \
    rm *.zip

ENV LD_LIBRARY_PATH /oracle/instantclient_19_6
COPY entrypoint.sh /usr/local/bin/
COPY test.sql /tmp/

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
