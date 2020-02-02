#!/bin/bash
set -e

BUILD_DIR="build"
SOURCES_DIR="${BUILD_DIR}/SOURCES"
RPMS_DIR="${BUILD_DIR}/RPMS"
REPOS_DIR="repos"
PKGS_DIR="../../packages"

run_docker() {
    DIR=$1
    CONTAINER=$2
    CMD=$3
    OPT="run --name dev_packages --privileged"
    OPT+=" -v ${DIR}:/data:Z"
    OPT+=" --rm -it ${CONTAINER} ${CMD}"
    echo "docker ${OPT}"
    docker ${OPT} 
}

clone_repo() {
    mkdir -p ${REPOS_DIR}
    pushd ${REPOS_DIR}
    git clone ${1}
}

copy_rpm() {
    mkdir -p ${PKGS_DIR}
    find . -type f -iname '*.rpm' -exec cp {} ${PKGS_DIR} \; 2> /dev/null
}

pkg_install() {
    dnf -y install $@
}

install_dev_tools() {
    # Install the Development tools (includes rpm-build)
    dnf -y group install "Development Tools"
    # Install rpmdevtools (for spectool)
    dnf -y install rpmdevtools
}

build_rpm() {
    # Create build/SOURCES dir
    mkdir -p ${SOURCES_DIR}

    # Download sources with spectool
    spectool -g -C ${SOURCES_DIR} ${1}

    # Copy files into build/SOURCES
    find . -maxdepth 1 -type f \
    \( -iname '*.*' ! -iname '*.md' ! -iname '.git*' \) \
    -exec cp {} ${SOURCES_DIR} \; 2> /dev/null

    # Build package with rpmbuild
    rpmbuild --define "_topdir `pwd`/${BUILD_DIR}" -ba ${1}
}

set +e
