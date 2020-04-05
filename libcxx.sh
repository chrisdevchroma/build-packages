#/bin/bash
. ./shared_functions.sh

build_libcxx() {
    # Clone repo with git and cd into the folder
    clone_repo https://github.com/chrisdevchroma/libcxx-rhel.git
    pushd libcxx-rhel
    # Checkout branch
    git checkout fedora/f30
    # Cleanup repo dir
    git clean -dfx; git reset --hard
    # Turn bootstrap on or off for libcxxabi loop
    if [[ $1 == "on" ]]; then
        sed -i 's/bootstrap 0/bootstrap 1/g' libcxx.spec
    else
        sed -i 's/bootstrap 1/bootstrap 0/g' libcxx.spec
    fi        
    # Build packages with rpmbuild
    build_rpm libcxx.spec
    # Copy packages
    copy_rpm
    popd; popd
}

# Install libcxx build dependencies
pkg_install clang cmake llvm-devel llvm-static python3
# Build libcxx with bootstrap on
build_libcxx on
# Install dependencies for libcxxabi-devel  
pkg_install "./${PKGS_DIR}/libcxx-[[:digit:]]*.x86_64.rpm"
pkg_install "./${PKGS_DIR}/libcxx-devel-[[:digit:]]*.x86_64.rpm"
# Build & install dependency libcxxabi-devel
./libcxxabi.sh
pkg_install "./${PKGS_DIR}/libcxxabi-[[:digit:]]*.x86_64.rpm"
pkg_install "./${PKGS_DIR}/libcxxabi-devel-[[:digit:]]*.x86_64.rpm"
# Rebuild libcxx with bootstrap off
build_libcxx off
# Re-install non-bootstrapped libcxx(-devel)
pkg_install "./${PKGS_DIR}/libcxx-[[:digit:]]*.x86_64.rpm"
pkg_reinstall "./${PKGS_DIR}/libcxx-devel-[[:digit:]]*.x86_64.rpm"
