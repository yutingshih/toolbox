#!/bin/bash

VER=${1:-6.3.0}
URL=https://ftp.gnu.org/gnu/gcc/gcc-${VER}/gcc-${VER}.tar.gz
TOPDIR=${2:-${HOME}}
SRCDIR=${TOPDIR}/gcc-${VER}
BLDDIR=${TOPDIR}/gcc-${VER}/build
APPDIR=${3:-${SRCDIR}}
MODULE=modules/gcc/${VER}

if [ ! -f ${MODULE} ]; then 
    cp modules/gcc/sample ${MODULE}
    sed -i "s~\${APPDIR}~${APPDIR}~g" ${MODULE}
    echo "Modulefile created"
else
    echo "Modulefile already exists"
fi

test ! -d ${SRCDIR} && wget ${URL} -O - | tar -xzC ${TOPDIR}

unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE

cd ${SRCDIR} && ${SRCDIR}/contrib/download_prerequisites

mkdir -p ${BLDDIR} && cd ${BLDDIR}
${SRCDIR}/configure --prefix=${APPDIR} --enable-languages=c,c++,fortran --disable-multilib
make -j $(nproc)
make install

cd ${TOPDIR}
