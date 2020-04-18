#/bin/bash
. ./shared_functions.sh

# Install SDL_image build dependencies
pkg_install gcc SDL-devel libjpeg-devel libpng-devel libtiff-devel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/SDL_image-rhel.git
pushd SDL_image-rhel
# Build package with rpmbuild
build_rpm SDL_image.spec
# Copy packages
copy_rpm
popd
