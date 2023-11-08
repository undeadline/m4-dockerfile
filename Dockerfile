FROM debian:stable-slim

ARG M4_VERSION="1.4.19" \
    INSTALL_PATH="/opt/m4"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y \
    build-essential \
    curl

# Don't show git messages about non-existent parent branch
RUN git config --global advice.detachedHead false

RUN mkdir -p /tmp/m4 ${INSTALL_PATH}

WORKDIR /tmp/m4
RUN curl https://ftp.gnu.org/gnu/m4/m4-${M4_VERSION}.tar.gz --output m4.tar.gz
RUN tar -xzf m4.tar.gz 
RUN cd m4-${M4_VERSION} && ./configure --prefix=${INSTALL_PATH} && make && make install