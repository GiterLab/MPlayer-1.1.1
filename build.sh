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
                        --disable-mencoder \
                        --enable-mplayer \
                        --disable-gui \
                        --disable-gtk1 \
                        --disable-termcap \
                        --enable-iconv \
                        --enable-langinfo \
                        --disable-lirc \
                        --disable-lircc \
                        --disable-joystick \
                        --disable-apple-remote \
                        --enable-apple-ir \
                        --disable-vm \
                        --disable-xf86keysym \
                        --disable-radio \
                        --enable-radio-capture \
                        --enable-radio-v4l2 \
                        --disable-radio-bsdbt848 \
                        --enable-tv \
                        --disable-tv-v4l1 \
                        --enable-tv-v4l2 \
                        --disable-tv-bsdbt848 \
                        --enable-pvr \
                        --enable-rtc \
                        --enable-networking \
                        --disable-winsock2_h \
                        --disable-smb \
                        --disable-live \
                        --disable-nemesi \
                        --disable-librtmp \
                        --enable-vcd \
                        --disable-bluray \
                        --enable-libdvdcss-internal \
                        --disable-cdparanoia \
                        --disable-cddb \
                        --enable-bitmap-font \
                        --enable-freetype \
                        --enable-unrarexec \
                        --disable-menu \
                        --enable-sortsub \
                        --disable-fribidi \
                        --disable-enca \
                        --disable-maemo \
                        --disable-macosx-finder \
                        --disable-macosx-bundle \
                        --enable-inet6 \
                        --disable-sctp \
                        --enable-gethostbyname2 \
                        --enable-ftp \
                        --disable-vstream \
                        --disable-w32threads \
                        --disable-os2threads \
                        --disable-ass-internal \
                        --disable-ass \
                        --disable-rpath \
                    --enable-png \
                    --enable-jpeg \
                    --enable-speex \
                    --enable-theora \
                    --enable-faad \
                    --enable-faac \
                    --enable-faac-lavc \
                    --enable-mad \
                    --enable-mp3lib \
                    --disable-decoder=AAC \
                        --enable-fbdev \
                        --enable-alsa \
                    --disable-runtime-cpudetection \
                    --enable-cross-compile \
                    --cc=arm-none-linux-gnueabi-gcc \
                    --host-cc=gcc \
                    --as=arm-none-linux-gnueabi-as \
                    --nm=arm-none-linux-gnueabi-nm \
                    --ar=arm-none-linux-gnueabi-ar \
                    --ranlib=arm-none-linux-gnueabi-ranlib \
                    --target=arm-linux \
                        --enable-armv5te \
                        --enable-vfpv3 \
                        --enable-neon \
                    --with-freetype-config="/home/tobyzxj/tools/arm-2013.11/arm-none-linux-gnueabi/libc/usr/bin/freetype-config"
        ;;
    make)
        echo "Make mplayer..."
        make -j4
        ;;
    clean)
        echo "Clean code..."
        git clean -fd
        ;;
    *)
        echo "Usage: $0 [OPTIONS]..."
        echo "  config --> run configure"
        echo "  make   --> make Makefile"
        echo "  clean  --> git clean -fd"
esac
exit 0

