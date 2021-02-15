#! /bin/bash

DOCKER_BUILDKIT=1 docker build packages/ --file=buildenvs/stretch-slim-gcc-10.2.dockerfile -t stretch-buildenv:gcc-10.2
