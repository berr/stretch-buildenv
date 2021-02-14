#! /bin/bash

docker build - < gcc_compilation_image.dockerfile -t stretch-slim-gcc



docker run -it --rm \
       -v $PWD/sources:$HOME/sources \
       -v $PWD/compilation_scripts:$HOME/scripts \
       -v $PWD/packages:$HOME/packages \
       -v /etc/passwd:/etc/passwd \
       -u $(id -u):$(id -g) \
       stretch-slim-gcc $HOME/scripts/compile_gcc.sh $1 $2 $3

