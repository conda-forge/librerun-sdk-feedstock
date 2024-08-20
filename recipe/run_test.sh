#!/bin/bash -e

# Test linking against the rerun library
cd examples/cpp/minimal

# Compile example that links assimp
cmake -GNinja -DCMAKE_BUILD_TYPE=Release .

cmake --build . --config Release
