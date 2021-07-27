#!/bin/bash

VER=6.3.0
NAME=gcc
URL=https://ftp.gnu.org/gnu/gcc/gcc-${VER}/gcc-${VER}.tar.gz

TOPDIR=${HOME}
SRCDIR=${TOPDIR}

BLDDIR=${TOPDIR}
APPDIR=${TOPDIR}

MODTOP=${TOPDIR}/modules
MODDIR=${MODTOP}/${NAME}
MODULE=${MODDIR}/${VER}

CONFIG=${SRCDIR}/configure
OPTION='--enable-languages=c,c++ --disable-multilib'


wget URL -O - | tar -zxC ${TOPDIR}
mkdir -p ${BLDDIR} && cd ${BLDDIR}
${CONFIG} --prefix=${APPDIR} ${OPTION}
make -j $(nproc)
make install