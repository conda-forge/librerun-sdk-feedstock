setlocal EnableDelayedExpansion

cd examples\cpp\minimal

:: Compile example that links rerun
cmake -GNinja -DCMAKE_BUILD_TYPE=Release .
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1
