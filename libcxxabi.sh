#/bin/bash
. ./shared_functions.sh

# Install libcxxabi build dependencies
pkg_install clang cmake llvm-devel llvm-static libcxx-devel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/libcxxabi-rhel.git
pushd libcxxabi-rhel
# Checkout branch
git checkout fedora/f30
# Build packages with rpmbuild
build_rpm libcxxabi.spec
# Copy packages
copy_rpm
popd
