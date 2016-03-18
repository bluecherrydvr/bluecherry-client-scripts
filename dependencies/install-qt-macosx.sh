#!/bin/bash

QT_SRC_VERSION=4.8.6
QT_SRC_FILE=qt-everywhere-opensource-src-$QT_SRC_VERSION.tar.gz
QT_SRC_DIR=qt-everywhere-opensource-src-$QT_SRC_VERSION
QT_SRC_URL=http://download.qt-project.org/archive/qt/4.8/${QT_SRC_VERSION}/$QT_SRC_FILE


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
    sudo port install wget
}

function downloadQtSources {
    wget $QT_SRC_URL
}

function unpackQtSources {
    tar xzf $QT_SRC_FILE
}

function buildQtFromSources {
    ./configure -prefix $HOME/dev/usr -confirm-license -opensource -no-qt3support \
      -no-xmlpatterns -openssl -opengl desktop -webkit -gtkstyle -nomake demos \
      -nomake examples -no-multimedia -no-audio-backend -no-phonon \
      -no-phonon-backend -no-svg -script -no-scripttools -declarative -no-declarative-debug \
      -rpath -release -arch x86
    make -j5
}

function installQtFromSources {
    make install
}

installQt
