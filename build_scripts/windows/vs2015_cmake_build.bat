@echo off

cd ..\..

set build_type=Debug
set batch_file_path=%cd%

if not exist cmake_build (
mkdir cmake_build
)


cd cmake_build
if exist build_vs2015_64 ( rd /s /q build_vs2015_64)
mkdir build_vs2015_64
cd build_vs2015_64
cmake %batch_file_path%  -G "Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=%build_type%
cd %batch_file_path% 


cd .
pause