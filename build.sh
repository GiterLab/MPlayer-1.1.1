#!/bin/bash

#
# Author: toby.zxj@gmail.com
# Date: 2014.06.04
#

# Define ARCH
ARCH=arm

# Current compile path
ARM_MPLAYER_BUILD_PATH=`pwd`

# Install path
ARM_MPLAYER_PREFIX=$ARM_MPLAYER_BUILD_PATH/build-out

# Compile tools
if [ "$ARCH" = "arm" ]; then
        echo "You select ARCH for arm"

        # Compile tools
        export CC=arm-none-linux-gnueabi-gcc
        export CXX=arm-none-linux-gnueabi-g++
        export LD=arm-none-linux-gnueabi-ld
        export AS=arm-none-linux-gnueabi-as
        export AR=arm-none-linux-gnueabi-ar
        export RANLIB=arm-none-linux-gnueabi-ranlib
        export STRIP=arm-none-linux-gnueabi-strip
        export HOST=arm-none-linux-gnueabi
        export TARGET=arm-none-linux-gnueabi

        # additional libs
        export CFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export CPPFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export CXXFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export LDFLAGS="-L$ARM_MPLAYER_PREFIX/lib"
elif [ "$ARCH" = "I386" ]; then
        echo "You select ARCH for I386"

        # Compile tools
        #export CC=arm-none-linux-gnueabi-gcc
        #export CXX=arm-none-linux-gnueabi-g++
        #export LD=arm-none-linux-gnueabi-ld
        #export AS=arm-none-linux-gnueabi-as
        #export AR=arm-none-linux-gnueabi-ar
        #export RANLIB=arm-none-linux-gnueabi-ranlib
        #export STRIP=arm-none-linux-gnueabi-strip
        export HOST=i386-linux
        export TARGET=i386-linux

        # additional libs
        export CFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export CPPFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export CXXFLAGS="-I$ARM_MPLAYER_PREFIX/include"
        export LDFLAGS="-L$ARM_MPLAYER_PREFIX/lib"
else
        echo "Unknown ARCH for $ARCH"
        exit $?
fi

echo $CFLAGS
echo $CPPFLAGS
echo $CXXFLAGS
echo $LDFLAGS

case "$1" in
    config)
        echo "Run configure to config mplayer..."
        export LD_LIBRARY_PATH=$CROSS_TOOLS/lib:$LD_LIBRARY_PATH
        export PKG_CONFIG_PATH=$CROSS_TOOLS/lib/pkgconfig:$PKG_CONFIG_PATH
        ./configure --prefix=$ARM_MPLAYER_PREFIX \
                    --disable-runtime-cpudetection \
                    --enable-cross-compile \
                    --cc=arm-none-linux-gnueabi-gcc \
                    --host-cc=gcc \
                    --as=arm-none-linux-gnueabi-as \
                    --nm=arm-none-linux-gnueabi-nm \
                    --ar=arm-none-linux-gnueabi-ar \
                    --ranlib=arm-none-linux-gnueabi-ranlib \
                    --target=arm-linux \
        ;;
    make)
        echo "Make mplayer..."
        make
        ;;
    clean)
        echo "Clean code..."
        make clean
        ;;
    *)
        echo "Usage: $0 [OPTIONS]..."
        echo "  config --> run configure"
        echo "  make   --> make Makefile"
        echo "  clean  --> make clean"
esac
exit 0

