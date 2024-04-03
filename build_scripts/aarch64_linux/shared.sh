#/bin/sh
with_ffmpeg=OFF
if [ ${with_ffmpeg} == "ON" ];then
	export PKG_CONFIG_PATH=/data/wensha2/tool/ffmpeg4.2.9/install/aarch64-linux-ffmpeg4.2.9/lib/pkgconfig
	export PKG_CONFIG_LIBDIR=/data/wensha2/tool/ffmpeg4.2.9/install/aarch64-linux-ffmpeg4.2.9/lib/pkgconfig
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
PLATFORM_BUILD_PATH="./build_aarch64_linux_shared"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir $PLATFORM_BUILD_PATH
fi
cd $PLATFORM_BUILD_PATH
rm -rf *
cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=${with_ffmpeg}														\
		-DBUILD_SHARED_LIBS=ON																\
		-DBUILD_LIST=calib3d,videoio														\
		-DCMAKE_GENERATOR="Unix Makefiles"                                  				\
		-DCMAKE_TOOLCHAIN_FILE=${batch_file_path}/cmake_add/aarch64_linux.toolchain.cmake 	\
		-DCMAKE_BUILD_TYPE=Release															\
		${batch_file_path} 

# make clean
make -j16
cd ../../

