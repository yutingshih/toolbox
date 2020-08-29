#!/bin/bash

VER=${1:-6.3.0}
URL=https://ftp.gnu.org/gnu/gcc/gcc-${VER}/gcc-${VER}.tar.gz
TOPDIR=${2:-${HOME}}
SRCDIR=${TOPDIR}/gcc-${VER}
BLDDIR=${TOPDIR}/gcc-${VER}/build
APPDIR=${3:-${SRCDIR}}
MODULE=modules/gcc/${VER}

if test ! -f ${MODULE}; then 
    cp modules/gcc/sample ${MODULE}
    sed -i "s~\${APPDIR}~${APPDIR}~g" ${MODULE}
fi

if [ ! -d ${SRCDIR} ]; then
    wget ${URL} -O - | tar -xzC ${TOPDIR}
fi

unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE

cd ${SRCDIR} && ${SRCDIR}/contrib/download_prerequisites

mkdir -p ${BLDDIR} && cd ${BLDDIR}
${SRCDIR}/configure --prefix=${APPDIR} --enable-languages=c,c++,gfortran --disable-multilib
make -j $(nproc)
make install

cd ${TOPDIR}
