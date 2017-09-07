#!/bin/bash

FFMPEG_SRC_VERSION=3.3.3
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
    sudo apt-get install yasm
}

function downloadFFmpegSources {
    wget $FFMPEG_SRC_URL
}

function unpackFFmpegSources {
    tar xjf $FFMPEG_SRC_FILE
}

function buildFFmpegFromSources {
    ./configure --prefix=/usr/lib/bluecherry/client/ --enable-shared --disable-programs --enable-pic --disable-stripping --disable-doc  --enable-protocol=file --enable-protocol=pipe --enable-protocol=http --enable-muxer=matroska --enable-muxer=mjpeg --enable-muxer=rtp --enable-demuxer=rtsp --enable-demuxer=matroska --enable-demuxer=mjpeg --enable-decoder=h264 --enable-decoder=hevc --enable-decoder=mpeg4 --enable-decoder=mjpeg --enable-parser=h264 --enable-parser=hevc --enable-parser=mpeg4video --enable-parser=mjpeg --enable-encoder=mjpeg --disable-lzma --enable-hwaccel=hevc_vaapi --enable-hwaccel=h264_vaapi --enable-vaapi
    make -j8
}

function installFFmpegFromSources {
    sudo make install
}

installFFmpeg

