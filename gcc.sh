#!/bin/bash

VER=${1:-6.3.0}
TOPDIR=${2:-${HOME}}
SRCDIR=${TOPDIR}/gcc-${VER}
BLDDIR=${TOPDIR}/gcc-${VER}/build
APPDIR=${3:-${SRCDIR}}
URL=https://mirror.ossplanet.net/gnu/gcc/gcc-${VER}/gcc-${VER}.tar.gz

if [[ ! -d ${SRCDIR} ]]; then
    wget ${URL} -O - | tar -xzC ${TOPDIR}
fi

unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE

cd ${SRCDIR} && ${SRCDIR}/contrib/download_prerequisites

mkdir -p ${BLDDIR} && cd ${BLDDIR}
${SRCDIR}/configure --prefix=${APPDIR} --enable-languages=c,c++ --disable-multilib
make -j $(nproc)
make install

cd ${TOPDIR}
