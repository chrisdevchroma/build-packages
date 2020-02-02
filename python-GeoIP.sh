#/bin/bash
. ./shared_functions.sh

# Install python-GeoIP build dependencies
pkg_install python2-devel python3-devel
# Build & install dependency GeoIP & GeoIP-devel -> see https://github.com/chrisdevchroma/GeoIP-rhel
./GeoIP.sh
pkg_install "${PKGS_DIR}/GeoIP-[:digit:]*.rpm"
pkg_install "${PKGS_DIR}/GeoIP-devel-*.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/python-GeoIP-rhel.git
pushd python-GeoIP-rhel
# Build package with rpmbuild
build_rpm python-GeoIP.spec
# Copy packages
copy_rpm
popd
