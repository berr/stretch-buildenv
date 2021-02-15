FROM debian:9-slim

RUN apt-get -qq update \
    && apt-get install --no-install-recommends -y \
       automake \
       autotools-dev \
       bzip2 \
       libc-dev \
       make \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

WORKDIR /
COPY ./binutils-2.36.1-bin.tar.bz2 ./gcc-10.2.0-bin.tar.bz2 ./cmake-3.19.4-Linux-x86_64.tar.gz .
RUN tar xjf gcc-10.2.0-bin.tar.bz2 --strip-components=1 -C / && rm gcc-10.2.0-bin.tar.bz2 && \
    tar xjf binutils-2.36.1-bin.tar.bz2 --strip-components=1 -C / && rm binutils-2.36.1-bin.tar.bz2 && \
    tar xzf cmake-3.19.4-Linux-x86_64.tar.gz --strip-components=1 -C /usr && rm cmake-3.19.4-Linux-x86_64.tar.gz && \
    echo '/lib64' | cat - /etc/ld.so.conf.d/x86_64-linux-gnu.conf > temp && mv temp /etc/ld.so.conf.d/x86_64-linux-gnu.conf && \
    ldconfig && \
    cd /bin && ln -s gcc cc

