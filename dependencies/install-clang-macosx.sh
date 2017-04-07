
CLANG_VERSION=3.9.0
CLANG_FILE=clang+llvm-$CLANG_VERSION-x86_64-apple-darwin.tar.xz
CLANG_URL=http://releases.llvm.org/$CLANG_VERSION/$CLANG_FILE

function installClang {
    downloadClang
    unpackClang
}

function downloadClang {
    wget $CLANG_URL
}

function unpackClang {
	mkdir -p $HOME/bc-dev/
    tar xf clang+llvm-$CLANG_VERSION-x86_64-apple-darwin.tar.xz -C $HOME/bc-dev/
    mv $HOME/bc-dev/clang+llvm-$CLANG_VERSION-x86_64-apple-darwin $HOME/bc-dev/clang
}

installClang
