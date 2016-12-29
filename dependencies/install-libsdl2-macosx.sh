#!/bin/bash

LIBSDL_SRC_VERSION=2.0.5
LIBSDL_SRC_FILE=SDL2-$LIBSDL_SRC_VERSION.tar.gz
LIBSDL_SRC_DIR=SDL2-$LIBSDL_SRC_VERSION
LIBSDL_SRC_URL=http://libsdl.org/release/$LIBSDL_SRC_FILE

function installLibSDL {
    downloadLibSDLSources
    unpackLibSDLSources
    patchLibSDLSources

    pushd $LIBSDL_SRC_DIR
    buildLibSDLFromSources
    installLibSDLFromSources
    popd
}


function downloadLibSDLSources {
    wget $LIBSDL_SRC_URL
}

function unpackLibSDLSources {
    tar xzf $LIBSDL_SRC_FILE
}

function patchLibSDLSources {
    patch -p0 < 01-sdl.patch
}


function buildLibSDLFromSources {
    if [ -e $HOME/dev/clang/bin/clang ] && [ -e $HOME/dev/clang/bin/clang++ ]; then
    CLANG_OPTIONS="CC=$HOME/dev/clang/bin/clang CXX=$HOME/dev/clang/bin/clang++"
    fi

   ./configure --prefix=$HOME/SDL_prefix $CLANG_OPTIONS --disable-shared --enable-static --enable-audio --disable-video --disable-render --disable-joystick --disable-haptic --disable-power --disable-events --enable-timers --disable-dummyaudio --disable-diskaudio --disable-libc --disable-video-cocoa

#CFLAGS="-arch i386" LDFLAGS="-arch i386"

   make -j4
}

function installLibSDLFromSources {
    make install
}

installLibSDL

