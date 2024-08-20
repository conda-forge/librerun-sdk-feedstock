#!/bin/bash -e

# Test linking against the rerun library
cd examples/cpp/minimal

# Compile example that links assimp
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DRERUN_FIND_PACKAGE:BOOL=ON .

cmake --build . --config Release
