FROM debian:stretch-slim

RUN apt-get -qq update \
    && apt-get install --no-install-recommends -y \
       build-essential \
       gcc-multilib \
       m4 \
       xz-utils \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}


