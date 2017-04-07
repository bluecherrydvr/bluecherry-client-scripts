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
    echo "no dependencies"
}

function downloadLibMPVSources {
    git clone $LIBMPV_SRC_URL
    git checkout v0.24.0
}

function buildLibMPVFromSources {

    ./bootstrap.py

    PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/bluecherry/client/lib/pkgconfig \
    CFLAGS="-I/usr/lib/bluecherry/client/include" \
    LDFLAGS="-L/usr/lib/bluecherry/client/lib -Wl,-rpath,/usr/lib/bluecherry/client/lib" \
    ./waf configure --prefix=$HOME/bc-dev/libmpv --disable-cplayer --enable-libmpv-shared --disable-libass --disable-manpage-build

    ./waf build
}

function installLibMPVFromSources {
    ./waf install
}

installLibMPV

