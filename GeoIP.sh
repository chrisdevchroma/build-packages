#/bin/bash
. ./shared_functions.sh

# Install GeoIP build dependencies
pkg_install zlib-devel
# Build & install dependency GeoIP-data -> see https://github.com/chrisdevchroma/GeoIP-GeoLite-data-rhel
./GeoIP-GeoLite-data.sh
pkg_install "${PKGS_DIR}/GeoIP-data-[:digit:]*.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/GeoIP-rhel.git
pushd GeoIP-rhel
# Build package with rpmbuild
build_rpm GeoIP.spec
# Copy packages
copy_rpm
popd
