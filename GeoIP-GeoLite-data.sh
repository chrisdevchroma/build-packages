#/bin/bash
. ./shared_functions.sh

# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/GeoIP-GeoLite-data-rhel.git
pushd GeoIP-GeoLite-data-rhel
# Build package with rpmbuild
build_rpm GeoIP-GeoLite-data.spec
# Copy packages
copy_rpm
popd
