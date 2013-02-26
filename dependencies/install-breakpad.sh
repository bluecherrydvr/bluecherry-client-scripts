#!/bin/bash

BREAKPAD_SRC_REPOSITORY=http://google-breakpad.googlecode.com/svn/trunk/
BREAKPAD_SRC_DIR=breakpad
BREAKPAD_INSTALL_PREFIX=/opt

function installBreakpad {
    installBuildDependencies
    downloadBreakpadSources

    pushd $BREAKPAD_SRC_DIR
    buildBreakpadFromSources
    installBreakpadFromSources
    popd
}

function installBuildDependencies {
    sudo apt-get install subversion
}

function downloadBreakpadSources {
    svn co -r677 $BREAKPAD_SRC_REPOSITORY $BREAKPAD_SRC_DIR
}

function buildBreakpadFromSources {
    ./configure -prefix $BREAKPAD_INSTALL_PREFIX
    make -j5
}

function installBreakpadFromSources {
    sudo make install
}

installBreakpad
