#!/bin/bash

QT_SRC_VERSION=4.8.7
QT_SRC_FILE=qt-everywhere-opensource-src-$QT_SRC_VERSION.tar.gz
QT_SRC_DIR=qt-everywhere-opensource-src-$QT_SRC_VERSION
QT_SRC_URL=http://download.qt.io/official_releases/qt/4.8/${QT_SRC_VERSION}/$QT_SRC_FILE


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
    wget --version 2>&1 1>/dev/null || sudo port install wget
}

function downloadQtSources {
    wget $QT_SRC_URL
}

function unpackQtSources {
    tar xzf $QT_SRC_FILE
}

function buildQtFromSources {
    ./configure -prefix $HOME/qt -confirm-license -opensource -no-qt3support \
      -no-xmlpatterns -openssl -opengl desktop -webkit -gtkstyle -nomake demos \
      -nomake examples -nomake docs -no-multimedia -no-audio-backend -no-phonon \
      -no-phonon-backend -no-svg -script -no-scripttools -declarative -no-declarative-debug \
      -rpath -release 
    make -j4
}

function installQtFromSources {
    make install
}

installQt
