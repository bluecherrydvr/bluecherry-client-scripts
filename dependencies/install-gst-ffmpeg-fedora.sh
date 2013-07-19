#!/bin/bash

GST_FFMPEG_VERSION=0.10.13
GST_FFMPEG_SRC_FILE=gst-ffmpeg-${GST_FFMPEG_VERSION}.tar.bz2
GST_FFMPEG_SRC_DIR=gst-ffmpeg-${GST_FFMPEG_VERSION}
GST_FFMPEG_SRC_URL=http://gstreamer.freedesktop.org/src/gst-ffmpeg/$GST_FFMPEG_SRC_FILE

function installGstFfmpeg {
    downloadGstFfmpegSources
    unpackGstFfmpegSources

    pushd $GST_FFMPEG_SRC_DIR
    patchGstFfmpegSources
    buildGstFfmpegFromSources
    installGstFfmpegFromSources
    popd
}

function downloadGstFfmpegSources {
    wget $GST_FFMPEG_SRC_URL
}

function unpackGstFfmpegSources {
    tar xjf $GST_FFMPEG_SRC_FILE
}

function patchGstFfmpegSources {
    patch -p1 < ../h264_qpel_mmx.patch
}

function buildGstFfmpegFromSources {
    ./configure --prefix=/usr/lib/bluecherry/gst
    make -j5
}

function installGstFfmpegFromSources {
    sudo make install
}

installGstFfmpeg
