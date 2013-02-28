#!/bin/bash

BREAKPAD_SRC_REPOSITORY=http://google-breakpad.googlecode.com/svn/trunk/
BREAKPAD_SRC_DIR=breakpad

function installBreakpad {
    installBuildDependencies
    downloadBreakpadSources

    pushd $BREAKPAD_SRC_DIR
    buildBreakpadFromSources
    popd
}

function installBuildDependencies {
    sudo apt-get install subversion
}

function downloadBreakpadSources {
    svn co -r677 $BREAKPAD_SRC_REPOSITORY $BREAKPAD_SRC_DIR
}

function buildBreakpadFromSources {
    ./configure
    make -j5
}

installBreakpad

