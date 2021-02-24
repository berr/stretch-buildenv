#! /bin/bash

set -e

pushd ~/sources

if [ ! -f "$HOME/packages/gcc-$1-bin.tar.bz2" ]; then
    tar xJf "gcc-$1-with-deps.tar.xz"
    pushd "gcc-$1"
    ./configure --prefix=$PWD/install/gcc --enable-languages=c,c++
    make -j$4
    make install-strip
    tar cjf "$HOME/packages/gcc-$1-bin.tar.bz2" --directory=$PWD/install gcc
    popd
    rm -Rf pushd "gcc-$1"
fi


if [ ! -f "$HOME/packages/binutils-$2-bin.tar.bz2" ]; then
    tar xJf "binutils-$2.tar.xz"
    pushd "binutils-$2"
    ./configure --prefix=$PWD/install/binutils
    make -j$4
    make install-strip
    tar cjf "$HOME/packages/binutils-$2-bin.tar.bz2" --directory=$PWD/install binutils/
    popd
    rm -Rf "binutils-$2"
fi


if [ ! -f "$HOME/packages/libtool-$3-bin.tar.bz2" ]; then
    tar xJf "libtool-$3.tar.xz"
    pushd "libtool-$3"
    ./configure --prefix=$PWD/install/libtool
    make -j$4
    make install-strip
    tar cjf "$HOME/packages/libtool-$3-bin.tar.bz2" --directory=$PWD/install libtool/
    popd
    rm -Rf "libtool-$3"
fi

popd
