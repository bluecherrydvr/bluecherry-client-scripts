#!/bin/bash

FFMPEG_SRC_VERSION=3.2.4
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
    if [ -e $HOME/bc-dev/clang/bin/clang ] && [ -e $HOME/bc-dev/clang/bin/clang++ ]; then
    CLANG_OPTIONS="--cc=$HOME/bc-dev/clang/bin/clang --cxx=$HOME/bc-dev/clang/bin/clang++"
    fi

    ./configure --prefix=$HOME/bc-dev/ffmpeg $CLANG_OPTIONS --yasmexe=/opt/local/bin/yasm --enable-shared --disable-static --disable-programs --disable-doc --enable-pic --enable-protocol=file --enable-protocol=pipe --enable-protocol=http --enable-muxer=matroska --enable-muxer=mjpeg --enable-muxer=rtp --enable-demuxer=rtsp --enable-demuxer=matroska --enable-demuxer=mjpeg --enable-decoder=h264 --enable-decoder=mpeg4 --enable-decoder=mjpeg --enable-parser=h264 --enable-parser=mpeg4video --enable-parser=mjpeg --enable-encoder=mjpeg

    make -j8
}

function installFFmpegFromSources {
    make install
}

installFFmpeg

