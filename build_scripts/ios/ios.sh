#-----------------------------------------------------------------
# Cmake build for iOS while -DMAXENGINE_PLATFORM="ios", with
# -IOS_PLATFOEM=OS, for armv7 armv7s arm64 arm64e (if applicable);
# -IOS_PLATFORM=SIMULATOR, for i386 x86_64;
#-----------------------------------------------------------------

use_math=ON
use_debug=ON
#cmake_build_type=Debug
cmake_build_type=Release
#cmake_build_type=RelWithDebInfo
ios_deployment=9.0
enable_bitcode=OFF

IOS_platform=OS
cd ../../
if [ ! -f "cmake_build" ];then
	mkdir cmake_build
fi
project_root_path=$(pwd)
echo "${project_root_path}"
cd cmake_build
PLATFORM_BUILD_PATH="./build_devices_ios_static"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir "$PLATFORM_BUILD_PATH"
fi
cd "$PLATFORM_BUILD_PATH"

cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=OFF																	\
		-DBUILD_SHARED_LIBS=OFF																\
		-DBUILD_LIST=calib3d,videoio														\
		-DCMAKE_TOOLCHAIN_FILE=${project_root_path}/cmake_add/ios.toolchain.cmake			\
		-DIOS_PLATFORM="$IOS_platform"														\
		-DENABLE_ARC=FALSE																	\
		-DUSE_MATH="$use_math" 																\
		-DCMAKE_BUILD_TYPE="$cmake_build_type" 												\
		-DIOS_DEPLOYMENT_TARGET="$ios_deployment"											\
		-DENABLE_BITCODE="$enable_bitcode"													\
		${project_root_path} 

make clean
make -j2

IOS_platform=SIMULATOR64
cd ../../
if [ ! -f "cmake_build" ];then
	mkdir cmake_build
fi
project_root_path=$(pwd)
echo "${project_root_path}"
cd cmake_build
PLATFORM_BUILD_PATH="./build_simulator64_ios_static"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir "$PLATFORM_BUILD_PATH"
fi

cd "$PLATFORM_BUILD_PATH"
cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=OFF																	\
		-DBUILD_SHARED_LIBS=OFF																\
		-DCMAKE_TOOLCHAIN_FILE=${project_root_path}/cmake_add/ios.toolchain.cmake			\
		-DIOS_PLATFORM="$IOS_platform"														\
		-DENABLE_ARC=FALSE																	\
		-DUSE_MATH="$use_math" 																\
		-DCMAKE_BUILD_TYPE="$cmake_build_type" 												\
		-DENABLE_BITCODE="$enable_bitcode"													\
		${project_root_path} 

make clean
make -j2

