#!/bin/bash
set -e

BUILD_DIR="build"
SOURCES_DIR="${BUILD_DIR}/SOURCES"
RPMS_DIR="${BUILD_DIR}/RPMS"
REPOS_DIR="repos"
PKGS_DIR="packages"
OS_RELEASE=$(cat /etc/redhat-release)
PYTHON_PREFIX=
PKG=

run_docker() {
    DIR=$1
    CONTAINER=$2
    CMD=$4
    OPT="run --name ${CONTAINER} --privileged"
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
    mkdir -p ../../${PKGS_DIR}
    find . -type f -iname '*.rpm' -exec cp -f {} ../../${PKGS_DIR} \; 2> /dev/null
}

check_python() {
    case ${OS_RELEASE} in
        "Fedora release"*)
            PYTHON_PREFIX="python3"
            ;;
        "CentOS Linux release 7"*)
            PYTHON_PREFIX="python"
            ;;
        "CentOS Linux release 8"*)
            PYTHON_PREFIX="python3"
            ;;
        "Red Hat Enterprise Linux"*"release 7"*)
            PYTHON_PREFIX="python"
            ;;
        "Red Hat Enterprise Linux release 8"*)
            PYTHON_PREFIX="python3"
            ;;
        *)
            PYTHON_PREFIX="echo unknown distro"
            ;;
        esac
}

check_pkg() {
    if [[ $EUID -ne 0 ]]; then
        PKG="sudo "
    fi
    case ${OS_RELEASE} in
        "Fedora release"*)
            PKG+="dnf"
            ;;
        "CentOS Linux release 7"*)
            PKG+="yum"
            ;;
        "CentOS Linux release 8"*)
            PKG+="dnf"
            ;;
        "Red Hat Enterprise Linux"*"release 7"*)
            PKG+="yum"
            ;;
        "Red Hat Enterprise Linux release 8"*)
            PKG+="dnf"
            ;;
        *)
            PKG+="echo unknown distro"
            ;;
        esac
}

pkg_install() {
    check_pkg
    ${PKG} -y install $@
}

pkg_reinstall() {
    check_pkg
    ${PKG} -y reinstall $@
}

install_dev_tools() {
    check_pkg
    # Install the Development tools (includes rpm-build)
    ${PKG} -y group install "Development Tools"
    # Install rpmdevtools (for spectool)
    ${PKG} -y install rpmdevtools
}

build_rpm() {
    # Create build/SOURCES dir
    mkdir -p ${SOURCES_DIR}

    # Download sources with spectool
    spectool -g -C ${SOURCES_DIR} ${1}

    # Copy files into build/SOURCES
    find . -maxdepth 1 -type f \
    \( -iname '*' ! -iname '*.md' ! -iname '.git*' ! -iname '*.spec' ! -iname 'sources' \) \
    -exec cp -f {} ${SOURCES_DIR} \; 2> /dev/null

    # Build package with rpmbuild
    rpmbuild --define "_topdir `pwd`/${BUILD_DIR}" -ba ${1}
}

set +e
