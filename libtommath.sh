#/bin/bash
. ./shared_functions.sh

# Install libtommath build dependencies
pkg_install ghostscript-tools-dvipdf libtiff-tools texlive-dvips-bin texlive-latex-bin-bin texlive-makeindex-bin texlive-mfware-bin texlive-updmap-map texlive-fancyhdr
# Clone repo with git and cd into the folder
clone_repo https://github.com/chrisdevchroma/libtommath-rhel.git
pushd libtommath-rhel
# Build packages with rpmbuild
build_rpm libtommath.spec
# Copy packages
copy_rpm
popd
