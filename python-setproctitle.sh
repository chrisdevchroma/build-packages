#/bin/bash
. ./shared_functions.sh

# Install python-setproctitle build dependencies
pkg_install python3-devel python3-nose
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/python-setproctitle-rhel.git
pushd python-setproctitle-rhel
# Build package with rpmbuild
build_rpm python-setproctitle.spec
# Copy packages
copy_rpm
popd
