#!/bin/bash

QT_SRC_VERSION=4.8.4
QT_SRC_FILE=qt-everywhere-opensource-src-$QT_SRC_VERSION.tar.gz
QT_SRC_DIR=qt-everywhere-opensource-src-$QT_SRC_VERSION
QT_SRC_URL=http://releases.qt-project.org/qt4/source/$QT_SRC_FILE

function installQt {
    installBuildDependencies
    downloadQtSources
    unpackQtSources

    pushd $QT_SRC_DIR
    buildQtFromSources
    installQtFromSources
    popd
}

function installBuildDependencies {
    # for download support
    sudo port install wget
    # for openssl support
    sudo port install libssl-dev
    # for opengl support
    sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev
}

function downloadQtSources {
    wget $QT_SRC_URL
}

function unpackQtSources {
    tar xzf $QT_SRC_FILE
}

function buildQtFromSources {
    ./configure -prefix /Users/vogel/dev/usr/lib/bluecherry/qt4.8/ -confirm-license -opensource \
      -no-qt3support -no-xmlpatterns -openssl -opengl desktop -webkit -gtkstyle \
      -nomake demos -nomake examples -no-dbus \
      -no-multimedia -no-audio-backend -no-phonon -no-phonon-backend -no-svg \
      -script -no-scripttools -declarative -no-declarative-debug -rpath -release \
      -arcg x86
    make -j5
}

function installQtFromSources {
    sudo make install
}

installQt
