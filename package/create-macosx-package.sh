#!/bin/bash

PRODUCT=bluecherry-client
VERSION=$1
GIT_URL=git://github.com/vogel/bluecherry-client.git

function usage
{
        echo "Usage: $0 package-version"
        echo "    package-version must be a git tag name"
}

if [ "!" == "!$VERSION" ]; then
        usage
        exit
fi

sudo port install git-core

PACKAGE_DIR=${PRODUCT}-${VERSION}

git clone $GIT_URL $PACKAGE_DIR
pushd $PACKAGE_DIR
git checkout $VERSION
git submodule init
git submodule update
find . -name ".git*" | xargs rm -rf

$HOME/dev/usr/bin/qmake -makefile "CONFIG+=release" "LIBAV_PATH=$HOME/dev/usr/"
make -j3
./mac/package.sh .

mv BluecherryClient.dmg ../

popd

