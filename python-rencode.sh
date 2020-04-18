#/bin/bash
. ./shared_functions.sh

# Install python-rencode build dependencies
pkg_install gcc python3-Cython python3-devel python3-wheel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/python-rencode-rhel.git
pushd python-rencode-rhel
# Build package with rpmbuild
build_rpm python-rencode.spec
# Copy packages
copy_rpm
popd
