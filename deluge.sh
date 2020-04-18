#/bin/bash
. ./shared_functions.sh

# Install deluge build dependencies
pkg_install desktop-file-utils python3-devel python3-setuptools python3-wheel intltool libappstream-glib systemd
# Build & install dependency rb_libtorrent & rb_libtorrent-python3 -> see https://github.com/chrisdevchroma/rb_libtorrent-rhel
./rb_libtorrent.sh
pkg_install "./${PKGS_DIR}/rb_libtorrent-[[:digit:]]*.x86_64.rpm"
pkg_install "./${PKGS_DIR}/rb_libtorrent-python3-[[:digit:]]*.x86_64.rpm"
# Build & install dependency python3-pygame -> see https://github.com/chrisdevchroma/pygame-rhel
./pygame.sh
pkg_install "${PKGS_DIR}/python3-pygame-[[:digit:]]*.x86_64.rpm"
# Build & install dependency python3-rencode -> see https://github.com/chrisdevchroma/python-rencode-rhel
./python-rencode.sh
pkg_install "${PKGS_DIR}/python3-rencode-[[:digit:]]*.x86_64.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/deluge-rhel.git
pushd deluge-rhel
# Build package with rpmbuild
build_rpm deluge.spec
# Copy packages
copy_rpm
popd
