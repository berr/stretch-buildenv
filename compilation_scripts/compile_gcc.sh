#! /bin/bash

set -e

pushd ~/sources

echo "~/packages/gcc-$1-bin.tar.bz2"
echo "~/packages/binutils-$2-bin.tar.bz2"

if [ ! -f "$HOME/packages/gcc-$1-bin.tar.bz2" ]; then
    tar xJf "gcc-$1-with-deps.tar.xz"
    pushd "gcc-$1"
    ./configure --prefix=$PWD/install/gcc --enable-languages=c,c++
    make -j$3
    make install-strip
    tar cjf "$HOME/packages/gcc-$1-bin.tar.bz2" --directory=$PWD/install gcc
    popd
    rm -Rf pushd "gcc-$1"
fi


if [ ! -f "$HOME/packages/binutils-$2-bin.tar.bz2" ]; then
    tar xJf "binutils-$2.tar.xz"
    pushd "binutils-$2"
    ./configure --prefix=$PWD/install/binutils
    make -j$3
    make install-strip
    tar cjf "$HOME/packages/binutils-$2-bin.tar.bz2" --directory=$PWD/install binutils/
    popd
    rm -Rf "binutils-$2"
fi

popd
