#!/bin/bash

FFMPEG_SRC_VERSION=2.4
FFMPEG_SRC_FILE=ffmpeg-$FFMPEG_SRC_VERSION.tar.bz2
FFMPEG_SRC_DIR=ffmpeg-$FFMPEG_SRC_VERSION
FFMPEG_SRC_URL=http://ffmpeg.org/releases/$FFMPEG_SRC_FILE

function installFFmpeg {
    installBuildDependencies
    downloadFFmpegSources
    unpackFFmpegSources

    pushd $FFMPEG_SRC_DIR
    buildFFmpegFromSources
    installFFmpegFromSources
    popd
}

function installBuildDependencies {
    sudo port install yasm wget
}

function downloadFFmpegSources {
    wget $FFMPEG_SRC_URL
}

function unpackFFmpegSources {
    tar xjf $FFMPEG_SRC_FILE
}

function buildFFmpegFromSources {
    ./configure --prefix=$HOME/dev/usr --enable-shared --disable-static --extra-cflags="-m32" --extra-ldflags="-m32" --disable-mmx --disable-debug --disable-optimizations --disable-programs --disable-doc

    make -j8
}

function installFFmpegFromSources {
    make install
}

installFFmpeg

