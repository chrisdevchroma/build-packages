#/bin/bash
. ./shared_functions.sh

# Install libcxxabi build dependencies
pkg_install clang cmake llvm-devel llvm-static libcxx-devel
# Clone repo with git and cd into the folder
clone_repo https://src.fedoraproject.org/rpms/libcxxabi.git
pushd libcxxabi
# Checkout branch
git checkout f30
# Build packages with rpmbuild
build_rpm libcxxabi.spec
# Copy packages
copy_rpm
popd
