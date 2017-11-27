#!/bin/bash
set -e
CURRDIR="$( cd "$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )" && pwd )"

. "${CURRDIR}/env.sh"

pushd .

export BOOST_VERSION="$1"
export BOOST_VERSION_FILENAME=$(echo ${BOOST_VERSION} | tr '.' '_')
export BOOST_ROOT="${TRAVIS_BUILD_DIR}/boost-${BOOST_VERSION}"
export BOOST_SOURCE="${BOOST_ROOT}/source"
export BOOST_INSTALL="${BOOST_ROOT}/install"

echo "Download Boost."
mkdir --parent "$BOOST_INSTALL"
cd "$BOOST_ROOT"
download_files_from_tar "https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_FILENAME}.tar.gz" "$BOOST_SOURCE"

echo "Build Boost."
cd "$BOOST_SOURCE"
./bootstrap.sh --with-libraries=filesystem,program_options,graph,serialization,thread,log --prefix="$BOOST_INSTALL"

./b2 link=shared install


popd