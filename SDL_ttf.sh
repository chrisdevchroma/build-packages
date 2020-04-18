#/bin/bash
. ./shared_functions.sh

# Install SDL_ttf build dependencies
pkg_install gcc SDL-devel freetype-devel zlib-devel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/SDL_ttf-rhel.git
pushd SDL_ttf-rhel
# Build package with rpmbuild
build_rpm SDL_ttf.spec
# Copy packages
copy_rpm
popd
