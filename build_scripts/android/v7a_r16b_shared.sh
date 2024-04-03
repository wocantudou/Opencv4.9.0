#!/bin/sh
set -e
NDK_ROOT=/data/wensha2/tool/android-ndk-r16b
# NDK_ROOT=/home/wensha2/tools/android-ndk-r16b
android_ndk=${NDK_ROOT}
toolchain=${NDK_ROOT}/build/cmake/android.toolchain.cmake
build_type=Release
#gernerator="Ninja"
android_platform=android-23
# android_platform=android-19
# android_platform=android-17
android_arm_neon=ON
#android_stl=gnustl_static
android_stl=c++_static
#androidchain=gcc
androidchain=clang

cd "../../"

#################################################armeabi-v7a
PWD=`pwd`
echo "PWD = ${PWD}"
cd "${PWD}"
if [ ! -d "cmake_build" ];then
    mkdir cmake_build
fi

cd "cmake_build"

with_ffmpeg=OFF
if [ ${with_ffmpeg} == "ON" ];then
	export PKG_CONFIG_LIBDIR=/data/wensha2/tool/ffmpeg4.2.9/install/arm-linux-androideabi-ffmpeg4.2.9/lib/pkgconfig
    export PKG_CONFIG_PATH=/data/wensha2/tool/ffmpeg4.2.9/install/arm-linux-androideabi-ffmpeg4.2.9/lib/pkgconfig
	echo "################################################## WITH FFMPEG ON #################"
else
	echo "################################################## WITH FFMPEG OFF ################"
fi

android_abi=armeabi-v7a
dir_prefix=build_
dir_suffix=_android_shared
PLATFORM_BUILD_PATH="${dir_prefix}${android_abi}${dir_suffix}"

if [ ! -d "${PLATFORM_BUILD_PATH}" ];then
    mkdir "${PLATFORM_BUILD_PATH}"
fi

cd "${PLATFORM_BUILD_PATH}"
PWD=`pwd`
echo "##################################################PWD = ${PWD}"

rm -rf *
cmake   -DBUILD_EXAMPLES=ON																	\
		-DBUILD_SHARED_LIBS=ON																\
		-DWITH_FFMPEG=${with_ffmpeg}														\
        -DBUILD_JAVA=OFF                                                                    \
        -DBUILD_ANDROID_EXAMPLES=OFF                                                        \
        -DBUILD_LIST=calib3d,videoio														\
        -DANDROID_ABI=${android_abi}                                                        \
        -DCMAKE_TOOLCHAIN_FILE=${toolchain}                                                 \
        -DANDROID_PLATFORM=${android_platform}                                              \
        -DCMAKE_BUILD_TYPE=${build_type}                                                    \
        -DANDROID_ARM_NEON=${android_arm_neon}                                              \
        -DANDROID_STL=${android_stl}                                                        \
        -DANDROID_TOOLCHAIN=${androidchain}                                                 \
        "../../" 


# make clean
make -j32

cd "../../"
