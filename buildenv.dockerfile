FROM stretch-slim

LABEL maintainer="felipe.silveira@khomp.com"

RUN apt-get -qq update \
    && apt-get install --no-install-recommends -y \
       automake \
       autotools-dev \
       bzip2 \
       libc-dev \
       libssl-dev \
       make \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

WORKDIR /
COPY ./packages/binutils-2.29.1-bin.tar.bz2 .
COPY ./packages/gcc-7.2.0-bin.tar.bz2 .
RUN tar xjf gcc-7.2.0-bin.tar.bz2 --strip-components=1 && rm gcc-7.2.0-bin.tar.bz2 && \
    tar xjf binutils-2.29.1-bin.tar.bz2 --strip-components=1 && rm binutils-2.29.1-bin.tar.bz2 && \
    echo '/lib64' | cat - /etc/ld.so.conf.d/x86_64-linux-gnu.conf > temp && mv temp /etc/ld.so.conf.d/x86_64-linux-gnu.conf && \
    ldconfig && \
    cd /bin && ln -s gcc cc

WORKDIR /build
COPY ./sources/cmake-3.10.0.tar.gz .
COPY ./scripts/build_all.sh .
COPY ./scripts/build_cmake.sh .

CMD ./build_all.sh
