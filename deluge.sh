#/bin/bash
. ./shared_functions.sh

# Install deluge build dependencies
pkg_install python3-devel python3-wheel libappstream-glib desktop-file-utils
# Build & install dependency rb_libtorrent & rb_libtorrent-python3 -> see https://github.com/chrisdevchroma/rb_libtorrent-rhel
#./rb_libtorrent.sh
pkg_install "${PKGS_DIR}/rb_libtorrent-1.*.x86_64.rpm"
pkg_install "${PKGS_DIR}/rb_libtorrent-python3-1.*.x86_64.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/deluge-rhel.git
pushd deluge-rhel
# Build package with rpmbuild
build_rpm deluge.spec
# Copy packages
copy_rpm
popd
