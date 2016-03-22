#!/bin/bash

BREAKPAD_SRC_REPOSITORY=http://google-breakpad.googlecode.com/svn/trunk/
BREAKPAD_SRC_DIR=breakpad

function installBreakpad {
    installBuildDependencies
    downloadBreakpadSources

    pushd $BREAKPAD_SRC_DIR
    buildFromSources
    popd
}

function installBuildDependencies {
    sudo apt-get install subversion make gcc g++ automake
}

function downloadBreakpadSources {
    svn co -r1223 $BREAKPAD_SRC_REPOSITORY $BREAKPAD_SRC_DIR
}


function buildFromSources {
    ./configure --disable-shared
    make -j5
}

installBreakpad

