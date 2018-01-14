#!/bin/bash

LIBMPV_SRC_DIR=mpv
LIBMPV_SRC_URL=https://github.com/mpv-player/$LIBMPV_SRC_DIR.git

function installLibMPV {
    installBuildDependencies
    downloadLibMPVSources

    pushd $LIBMPV_SRC_DIR
    buildLibMPVFromSources
    installLibMPVFromSources
    popd
}

function installBuildDependencies {
    libAss
}

function libAss {
   git clone https://github.com/libass/libass.git
   pushd libass
   buildLibAss
   popd
}

function buildLibAss {
   git checkout '0.13.6'
   ./autogen.sh
   #PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:$HOME/bc-dev/lib/pkgconfig \
   ./configure --prefix=$HOME/bc-dev --enable-static --disable-shared \
    --disable-harfbuzz --disable-fontconfig --disable-require-system-font-provider --disable-asm
   make && make install
}

function downloadLibMPVSources {
    git clone $LIBMPV_SRC_URL
}

function buildLibMPVFromSources {

    git checkout 'v0.26.0'
    ./bootstrap.py

    PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/bluecherry/client/pkgconfig:$HOME/bc-dev/lib/pkgconfig \
    CFLAGS="-I/usr/lib/bluecherry/client/include" \
    LDFLAGS="-L/usr/lib/bluecherry/client/lib -Wl,-rpath,/usr/lib/bluecherry/client" \
    ./waf configure --prefix=$HOME/bc-dev --disable-cplayer --enable-libmpv-static --enable-libass --disable-manpage-build \
    --disable-libarchive --disable-html-build --disable-pdf-build --disable-iconv --disable-termios --disable-shm --disable-libsmbclient \
    --disable-lua --disable-encoding --disable-libbluray --disable-dvdread --disable-dvdnav --disable-cdda --disable-uchardet --disable-rubberband \
    --disable-lcms2 --disable-vapoursynth --disable-vapoursynth-lazy --disable-libavdevice --disable-oss-audio --disable-rsound --disable-sndio \
    --disable-jack --disable-openal --disable-opensles --disable-wayland --disable-caca --disable-drm --disable-gbm \
    --disable-egl-x11 --disable-egl-drm --disable-gl-wayland --disable-vdpau --disable-vdpau-hwaccel --disable-cuda-hwaccel \
    --disable-libv4l2 --disable-tv-v4l2 --disable-tv --disable-dvbin --disable-audio-input --disable-jpeg --disable-pulse

    ./waf build
}

function installLibMPVFromSources {
    ./waf install
}

installLibMPV

