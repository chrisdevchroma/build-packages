#/bin/bash
. ./shared_functions.sh

# Install SDL_mixer build dependencies
pkg_install SDL-devel flac-devel fluidsynth-devel libvorbis-devel mikmod-devel
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/SDL_mixer-rhel.git
pushd SDL_mixer-rhel
# Build package with rpmbuild
build_rpm SDL_mixer.spec
# Copy packages
copy_rpm
popd
