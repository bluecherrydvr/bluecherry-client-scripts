#!/bin/bash

VERSION=$1
GIT_TAG=$2
GIT_URL=git://github.com/vogel/bluecherry-client.git

function usage
{
        echo "Usage: $0 package-version"
        echo "    package-version must be a git tag name"
}

function prepareSpec
{
        VERSION=$1
        sed rpm/bluecherry-client.spec.in -e"s/\\\${VERSION}/${VERSION}/g" > ~/rpmbuild/SPECS/bluecherry-client.spec
}

function createSourcePackage
{
        VERSION=$1
        GIT_TAG=$2
        ./create-source-package.sh $VERSION $GIT_TAG
}

function copyPackageToRPMSources
{
        VERSION=$1
        cp bluecherry-client-$VERSION.tar.bz2 ~/rpmbuild/SOURCES/
}

function copyPatchesToRPMSources
{
        cp rpm/patches/* ~/rpmbuild/SOURCES/
}

function createRPMPackage
{
        pushd ~/rpmbuild/SPECS/
        QA_RPATHS=$[ 0xFFFF ] rpmbuild -ba bluecherry-client.spec 
        popd
}

if [ "!" == "!$VERSION" ]; then
        usage
        exit
fi

prepareSpec $VERSION
createSourcePackage $VERSION $GIT_TAG
copyPackageToRPMSources $VERSION
copyPatchesToRPMSources
createRPMPackage
