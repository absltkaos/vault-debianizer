#!/bin/bash
set -e
version="$1"
new_release='false'
proj_root=$(dirname "$0")
proj_root=$(dirname "$proj_root")

cd ${proj_root}

#Clean up any possible old directories, and try to find and download the binary from HashiCorp
rm -rf docs/
rm -f vault
./get_release $version > "${proj_root}/debian/changelog"
cp docs/LICENSE "${proj_root}/debian/copyright"

#Build the package
if dpkg-buildpackage -us -uc ; then
    mkdir -p builds
    mv ../*.deb ../*.changes ../*.dsc ../*_*.tar.gz builds/
else
    echo "Package building failed. :-("
    exit 1
fi

#List the files created from building the package
echo "Files built (at ./builds):"
if [ -d "builds/" ] ; then
    ls -l builds/
fi
