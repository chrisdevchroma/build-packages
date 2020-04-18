#/bin/bash
. ./shared_functions.sh

# Install pygame build dependencies
pkg_install gcc portmidi-devel libpng-devel libjpeg-devel libX11-devel freetype-devel SDL-devel python3-devel python3-numpy python3-Cython python3-setuptools
# Build & install dependency SDL_image-devel -> see https://github.com/chrisdevchroma/SDL_image-rhel
./SDL_image.sh
pkg_install "${PKGS_DIR}/SDL_image-[[:digit:]]*.x86_64.rpm"
pkg_install "${PKGS_DIR}/SDL_image-devel-[[:digit:]]*.x86_64.rpm"
# Build & install dependency SDL_mixer-devel -> see https://github.com/chrisdevchroma/SDL_mixer-rhel
./SDL_mixer.sh
pkg_install "${PKGS_DIR}/SDL_mixer-[[:digit:]]*.x86_64.rpm"
pkg_install "${PKGS_DIR}/SDL_mixer-devel-[[:digit:]]*.x86_64.rpm"
# Build & install dependency SDL_ttf-devel -> see https://github.com/chrisdevchroma/SDL_ttf-rhel
./SDL_ttf.sh
pkg_install "${PKGS_DIR}/SDL_ttf-[[:digit:]]*.x86_64.rpm"
pkg_install "${PKGS_DIR}/SDL_ttf-devel-[[:digit:]]*.x86_64.rpm"
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/pygame-rhel.git
pushd pygame-rhel
# Build package with rpmbuild
build_rpm pygame.spec
# Copy packages
copy_rpm
popd
