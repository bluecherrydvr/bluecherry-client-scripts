#!/bin/bash

QT_SRC_VERSION=4.8.5
QT_SRC_FILE=qt-everywhere-opensource-src-$QT_SRC_VERSION.tar.gz
QT_SRC_DIR=qt-everywhere-opensource-src-$QT_SRC_VERSION
QT_SRC_URL=http://download.qt-project.org/archive/qt/4.8/${QT_SRC_VERSION}/$QT_SRC_FILE

function installQt {
    installBuildDependencies
    downloadQtSources
    unpackQtSources
    patchQtSources

    pushd $QT_SRC_DIR
    buildQtFromSources
    installQtFromSources
    popd
}

function installBuildDependencies {
    # for openssl support
    sudo apt-get install libssl-dev
    # for opengl support
    sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev
    # for webkit support
    sudo apt-get install libxrender-dev
    # for gtkstyle
    sudo apt-get install libgtk2.0-dev
}

function downloadQtSources {
    wget $QT_SRC_URL
}

function unpackQtSources {
    tar xzf $QT_SRC_FILE
}

function patchQtSources {
    patch -p1 < 01-qt.patch
}

function buildQtFromSources {
    ./configure -prefix /usr/lib/bluecherry/qt4.8/ -confirm-license -opensource \
      -no-qt3support -no-xmlpatterns -openssl -opengl desktop -webkit -gtkstyle \
      -qtlibinfix -bluecherry -nomake demos -nomake examples  \
      -no-multimedia -no-audio-backend -no-phonon -no-phonon-backend -no-svg \
      -script -no-scripttools -declarative -no-declarative-debug -rpath -release
    make -j5
}

function installQtFromSources {
    sudo make install
}

installQt
