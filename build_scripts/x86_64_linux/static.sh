#/bin/sh

with_ffmpeg=ON
if [ ${with_ffmpeg} == "ON" ];then
	# 172.20.191.53
	# MY_FFMPEG_PATH=/data/wensha2/tool/ffmpeg4.2.9/install/x86_64-intellinux64-ffmpeg4.2.9
	# WSL2
	MY_FFMPEG_PATH=/home/wensha2/workspace/opt/ffmpeg4.2.9/install/x86_64-intellinux64-ffmpeg4.2.9
	export PKG_CONFIG_LIBDIR=${MY_FFMPEG_PATH}/lib/pkgconfig
	export PKG_CONFIG_PATH=${MY_FFMPEG_PATH}/lib/pkgconfig
	# export CMAKE_INCLUDE_PATH=${MY_FFMPEG_PATH}/include:${CMAKE_INCLUDE_PATH}
	# export CMAKE_LIBRARY_PATH=${MY_FFMPEG_PATH}/lib:${CMAKE_LIBRARY_PATH}
	echo "################################################## WITH FFMPEG ON #################"
else
	echo "################################################## WITH FFMPEG OFF ################"
fi

cd ../../

if [ ! -f "cmake_build" ];then
	mkdir cmake_build
fi

CMAKE=cmake
batch_file_path=$(pwd)
echo "${batch_file_path}"

cd cmake_build
PLATFORM_BUILD_PATH="./build_x86_64_linux_static"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir ${PLATFORM_BUILD_PATH}
fi
cd ${PLATFORM_BUILD_PATH}

rm -rf *
cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=${with_ffmpeg}														\
		-DBUILD_SHARED_LIBS=OFF																\
		-DBUILD_LIST=calib3d,videoio														\
		-DCMAKE_GENERATOR="Unix Makefiles"                                  				\
		-DCMAKE_TOOLCHAIN_FILE=${batch_file_path}/cmake_add/x86_64_linux.toolchain.cmake 	\
		-DCMAKE_BUILD_TYPE=Release															\
		${batch_file_path}
		
# make clean
# make -j2
# cd ../../


