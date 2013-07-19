#!/bin/bash

function installBuildDeps
{
        sudo yum install -y \
                @development-tools \
                fedora-packager \
                git-core \
                gcc \
                gcc-c++ \
                cmake \
                yasm \
                gstreamer \
                gstreamer-devel \
                gstreamer-plugins-base \
                gstreamer-plugins-base-devel \
                libSM-devel \
                openssl-devel \
                wget \
                mesa-libGL-devel \
                mesa-libGLU-devel \
                libXrender-devel \
                gtk2-devel
}

function disablePrelink
{
        sudo sed -i /etc/sysconfig/prelink -e"s/PRELINKING=yes/PRELINKING=no/g"
        sudo /etc/cron.daily/prelink
}

function setUpEnvironment
{
        rpmdev-setuptree
}

installBuildDeps
disablePrelink
setUpEnvironment
