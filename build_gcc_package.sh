#!/bin/bash

set -e

usage() {
    echo "Usage: build_gcc_package.sh --gcc_version=10.2.0 --binutils_version=2.36.1 --libtool_version=2.4.6"
}

usage_and_exit() {
    usage
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

if [ "$#" -lt 3 ]; then
    echo "Invalid number of parameters"
    usage_and_exit
fi


JOBS=4

for i in "$@"
do
case $i in
    --gcc_version=*)
    GCC_VERSION="${i#*=}"
    shift # past argument=value
    ;;
    --binutils_version=*)
    BINUTILS_VERSION="${i#*=}"
    shift # past argument=value
    ;;
    --libtool_version=*)
    LIBTOOL_VERSION="${i#*=}"
    shift
    ;;        
    --jobs=*)
    JOBS="${i#*=}"
    shift # past argument=value
    ;;
    *)
        echo "Unknown option: ${i#*=}"
        usage_and_exit
    ;;
esac
done


if [ ! -f "sources/gcc-$GCC_VERSION-with-deps.tar.xz" ]; then
    if [ ! -f "sources/gcc-$GCC_VERSION.tar.gz" ]; then
        wget -P sources "http://gnu.c3sl.ufpr.br/ftp/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz"
    fi
    pushd sources
    tar xzf "gcc-$GCC_VERSION.tar.gz"
    pushd "gcc-$GCC_VERSION"
    ./contrib/download_prerequisites
    popd
    tar Jcf "gcc-$GCC_VERSION-with-deps.tar.xz" "gcc-$GCC_VERSION"
    rm -Rf "gcc-$GCC_VERSION"
fi


if [ ! -f "sources/binutils-$BINUTILS_VERSION.tar.xz" ]; then
    wget -P sources "http://gnu.c3sl.ufpr.br/ftp/binutils/binutils-$BINUTILS_VERSION.tar.xz"
fi

if [ ! -f "sources/libtool-$LIBTOOL_VERSION.tar.xz" ]; then
    wget -P sources "http://gnu.c3sl.ufpr.br/ftp/libtool/libtool-$LIBTOOL_VERSION.tar.xz"
fi


./run_compilation_docker.sh $GCC_VERSION $BINUTILS_VERSION $LIBTOOL_VERSION $JOBS
