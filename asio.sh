#/bin/bash
. ./shared_functions.sh

# Install asio build dependencies
pkg_install boost-devel openssl-devel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/asio-rhel.git
pushd asio-rhel
# Checkout branch
git checkout fedora/f30
# Build packages with rpmbuild
build_rpm asio.spec
# Copy packages
copy_rpm
popd
