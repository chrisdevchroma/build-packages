#/bin/bash
. ./shared_functions.sh

# Install deluge build dependencies
pkg_install python3-devel python3-wheel
# Build & install dependency rb_libtorrent & rb_libtorrent-python3 -> see https://github.com/chrisdevchroma/rb_libtorrent-rhel
./rb_libtorrent.sh
pkg_install "${PKGS_DIR}/rb_libtorrent-[:digit:]*.rpm"
pkg_install "${PKGS_DIR}/rb_libtorrent-python3-*.rpm"
# Build & install dependency python3-setproctitle -> see https://github.com/chrisdevchroma/python-setproctitle-rhel
./python-setproctitle.sh
pkg_install "${PKGS_DIR}/python3-setproctitle-*.rpm"
# Build & install dependency python3-GeoIP -> see https://github.com/chrisdevchroma/python-GeoIP-rhel
./python-GeoIP.sh
pkg_install "${PKGS_DIR}/python3-GeoIP-*.rpm"
# Build & install dependency python3-pygame -> see https://github.com/chrisdevchroma/pygame-rhel
./pygame.sh
pkg_install "${PKGS_DIR}/python3-pygame-*.rpm"
# Build & install dependency python3-rencode -> see https://github.com/chrisdevchroma/python-rencode-rhel
./python-rencode.sh
pkg_install "${PKGS_DIR}/python3-rencode-*.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/deluge-rhel.git
pushd deluge-rhel
# Build package with rpmbuild
build_rpm deluge.spec
# Copy packages
copy_rpm
popd
