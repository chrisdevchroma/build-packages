#/bin/bash
. ./shared_functions.sh

# Install rb_libtorrent build dependencies
pkg_install boost-devel boost-python3-devel chrpath python3-devel
# Build & install dependency asio-devel -> see https://github.com/chrisdevchroma/asio-rhel
./asio.sh
pkg_install "./${PKGS_DIR}/asio-devel-[[:digit:]]*.x86_64.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/rb_libtorrent-rhel.git
pushd rb_libtorrent-rhel
# Build package with rpmbuild
build_rpm rb_libtorrent.spec
# Copy packages
copy_rpm
popd
