#!/bin/bash

set -ex

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# https://github.com/rust-lang/cargo/issues/10583#issuecomment-1129997984
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export IS_IN_RERUN_WORKSPACE=no

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

# The CI environment variable means something specific to Rerun. Unset it.
unset CI

if [[ "${target_platform}" == osx-* ]]; then
  export CMAKE_LINKER_TYPE="LLD"
else
  export CMAKE_LINKER_TYPE="DEFAULT"
fi

mkdir build_cxx
cd build_cxx

cmake ${CMAKE_ARGS} -GNinja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DRERUN_ARROW_LINK_SHARED:BOOL=ON \
      -DRERUN_DOWNLOAD_AND_BUILD_ARROW:BOOL=OFF \
      -DRERUN_BUILD_CPP_TESTS:BOOL=OFF \
      -DRERUN_BUILD_DOC_SNIPPETS:BOOL=OFF \
      -DRERUN_BUILD_EXAMPLES:BOOL=OFF \
      -DRERUN_BUILD_TESTS:BOOL=OFF \
      -DRERUN_INSTALL_RERUN_C:BOOL=OFF \
      -DCMAKE_FIND_PACKAGE_TARGETS_GLOBAL:BOOL=ON \
      -DCMAKE_LINKER_TYPE:STRING=${CMAKE_LINKER_TYPE}
cmake --build . --config Release --target install
