#!/bin/bash

BREAKPAD_SRC_REPOSITORY=http://google-breakpad.googlecode.com/svn/trunk/
BREAKPAD_SRC_DIR=breakpad

function installBreakpad {
    installBuildDependencies
    downloadBreakpadSources

    pushd $BREAKPAD_SRC_DIR
    buildFromSources
    pushd src/tools/linux/dump_syms
    ARCH=`uname -p`
    if [ "$ARCH" == "x86_64" ]; then
        updateMakefileFor64bit
    fi
    buildFromSources
    popd
    popd
}

function installBuildDependencies {
    sudo apt-get install subversion gcc g++ autotools
}

function downloadBreakpadSources {
    svn co -r677 $BREAKPAD_SRC_REPOSITORY $BREAKPAD_SRC_DIR
}

function updateMakefileFor64bit {
    sed -i "s/-m32//g" Makefile
}

function buildFromSources {
    ./configure --disable-shared
    make -j5
}

installBreakpad

