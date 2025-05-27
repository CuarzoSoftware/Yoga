#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

dependencies=("curl" "tar" "cmake")

for dep in ${dependencies[@]}; do
    if ! command -v $dep &>/dev/null; then
        echo "Dependency ${dep} not installed. Aborting..."
        exit 1
    fi
done

echo "Checking if Yoga is already installed"
cmake --find-package -DNAME=yoga -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST
ret=$?

if [[ "$ret" == "0" ]]; then
    echo "Yoga is already installed!"
    read -e -p "Do you wish to proceed? (y/n) " choice
    if [[ "$choice" == [Yy]* ]]; then
        echo "Installing yoga..."
    else
        echo "Aborting..."
        exit 1
    fi
fi

YOGA_RELEASE="$(cat ${SCRIPT_DIR}/VERSION)"
YOGA_TAR="v${YOGA_RELEASE}.tar.gz"

echo "Downloading yoga source code, version: ${YOGA_RELEASE}"

if [[ -f "${SCRIPT_DIR}/${YOGA_TAR}" ]]; then
    echo "Cleaning old build artifacts"
    rm "${SCRIPT_DIR}/${YOGA_TAR}"
fi

if [[ -d "${SCRIPT_DIR}/yoga-${YOGA_RELEASE}" ]]; then
    echo "Cleaning old extract artifacts"
    rm -rf "${SCRIPT_DIR}/yoga-${YOGA_RELEASE}"
fi

curl -L \
     --fail \
     "https://github.com/facebook/yoga/archive/refs/tags/${YOGA_TAR}" \
     --output "${SCRIPT_DIR}/${YOGA_TAR}"
ret=$?

if [[ "${ret}" != "0" ]]; then
    echo "Failed to download yoga"
    exit $ret
fi

echo "Extracting yoga source code..."
tar xzvf "${SCRIPT_DIR}/${YOGA_TAR}" -C "${SCRIPT_DIR}"

pushd "${SCRIPT_DIR}/yoga-${YOGA_RELEASE}" || exit 1

echo "Disabling tests compilation"
sed -i '/add_subdirectory(tests)/d' "CMakeLists.txt"

echo "Building yoga ${YOGA_RELEASE}..."
cmake -S . -B build
cmake --build build

echo "Installing yoga ${YOGA_RELEASE} using sudo..."
sudo cmake --install build

popd || exit 1
