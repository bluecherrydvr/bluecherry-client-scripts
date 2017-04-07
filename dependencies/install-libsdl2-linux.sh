#!/bin/bash

LIBSDL_SRC_VERSION=2.0.5
LIBSDL_SRC_FILE=SDL2-$LIBSDL_SRC_VERSION.tar.gz
LIBSDL_SRC_DIR=SDL2-$LIBSDL_SRC_VERSION
LIBSDL_SRC_URL=http://libsdl.org/release/$LIBSDL_SRC_FILE

function installLibSDL {
    installBuildDependencies
    downloadLibSDLSources
    unpackLibSDLSources

    pushd $LIBSDL_SRC_DIR
    buildLibSDLFromSources
    installLibSDLFromSources
    popd
}

function installBuildDependencies {
    #sudo apt-get install libasound2-dev
    echo "no dependencies"
}

function downloadLibSDLSources {
    wget $LIBSDL_SRC_URL
}

function unpackLibSDLSources {
    tar xzf $LIBSDL_SRC_FILE
}

function buildLibSDLFromSources {
   ./configure --prefix=$HOME/bc-dev/SDL_prefix --disable-shared --enable-static --enable-audio --disable-video --disable-render --disable-joystick --disable-haptic --disable-power  --disable-oss --enable-alsa --enable-pulseaudio --disable-video-dummy --disable-libudev --disable-dbus --disable-ibus --disable-nas --disable-sndio --disable-esd --disable-input-tslib --disable-diskaudio --disable-dummyaudio
   make -j8
}

function installLibSDLFromSources {
    make install
}

installLibSDL

