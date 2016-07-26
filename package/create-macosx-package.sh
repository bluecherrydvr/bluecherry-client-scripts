#!/bin/bash

PRODUCT=bluecherry-client
VERSION=$1
GIT_URL=git://github.com/bluecherrydvr/bluecherry-client.git

function usage
{
        echo "Usage: $0 package-version"
        echo "    package-version must be a git tag name"
}

if [ "!" == "!$VERSION" ]; then
        usage
        exit
fi

sudo port install cmake git-core

PACKAGE_DIR=${PRODUCT}-${VERSION}

git clone $GIT_URL $PACKAGE_DIR
pushd $PACKAGE_DIR
git checkout $VERSION
git submodule init
git submodule update
find . -name ".git*" | xargs rm -rf

cp ../macosx.cmake ./user.cmake

mkdir build
pushd build

export QTDIR=$HOME/dev/usr
export PATH="$HOME/dev/usr/bin:${PATH}"

#use GCC, not clang
CXX=/usr/bin/g++ cmake ../
make
make deploy
make create-symbols

popd

./mac/package.sh build

mv BluecherryClient.dmg ../BluecherryClient-${VERSION}.dmg

popd

