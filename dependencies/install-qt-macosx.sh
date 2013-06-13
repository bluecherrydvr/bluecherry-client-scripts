#!/bin/bash

QT_SRC_VERSION=4.8.4
QT_GIT_URL=git://gitorious.org/qt/qt.git
QT_SRC_DIR=qt-4.8.5

function installQt {
    installBuildDependencies
    downloadQtFromGit

    pushd $QT_SRC_DIR
    buildQtFromSources
    installQtFromSources
    popd
}

function installBuildDependencies {
    # for download support
    sudo port install git-core
    # for openssl support
    sudo port install libssl-dev
    # for opengl support
    sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev
}

function downloadQtFromGit {
    git clone $QT_GIT_URL $QT_SRC_DIR
}

function buildQtFromSources {
    ./configure -prefix $HOME/dev/usr -confirm-license -opensource -no-qt3support \
      -no-xmlpatterns -openssl -opengl desktop -webkit -gtkstyle -nomake demos \
      -nomake examples -no-dbus -no-multimedia -no-audio-backend -no-phonon \
      -no-phonon-backend -no-svg -script -no-scripttools -declarative -no-declarative-debug \
      -rpath -release -arch x86
    make -j5
}

function installQtFromSources {
    make install
}

installQt
