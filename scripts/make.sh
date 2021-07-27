#!/bin/bash

VER=${1:-4.2}
URL=https://ftp.gnu.org/gnu/make/make-${VER}.tar.gz
TOPDIR=${2:-${HOME}}
SRCDIR=${TOPDIR}/make-${VER}
BLDDIR=${TOPDIR}/make-${VER}/build
APPDIR=${3:-${SRCDIR}}
MODULE=modules/make/${VER}

if [ ! -f ${MODULE} ]; then 
    cp modules/make/sample ${MODULE}
    sed -i "s~\${APPDIR}~${APPDIR}~g" ${MODULE}
    echo "Modulefile created"
else
    echo "Modulefile already exists"
fi

test ! -d ${SRCDIR} && wget ${URL} -O - | tar -zxC ${TOPDIR}
mkdir -p ${BLDDIR} && cd ${BLDDIR}
${SRCDIR}/configure --prefix=${APPDIR}
make -j$(nproc)
make install

cd ${TOPDIR}
