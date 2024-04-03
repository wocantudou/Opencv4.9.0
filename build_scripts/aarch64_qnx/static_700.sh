#/bin/sh
# 172.20.31.106
source /data/wensha2/tool/QNX/sv-g6sh-qnx-system-sdk/qnxsdp-env.sh

with_ffmpeg=OFF
if [ ${with_ffmpeg} == "ON" ];then
	export PKG_CONFIG_PATH=/data/wensha2/tool/ffmpeg4.2.9/install/aarch64-qnx700-ffmpeg4.2.9/lib/pkgconfig
	export PKG_CONFIG_LIBDIR=/data/wensha2/tool/ffmpeg4.2.9/install/aarch64-qnx700-ffmpeg4.2.9/lib/pkgconfig
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
PLATFORM_BUILD_PATH="./build_aarch64_qnx700_static"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir $PLATFORM_BUILD_PATH
fi
cd $PLATFORM_BUILD_PATH
rm -rf *
cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=${with_ffmpeg}														\
		-DBUILD_SHARED_LIBS=OFF																\
		-DENABLE_NEON=ON																	\
		-DBUILD_LIST=calib3d,videoio														\
		-DCMAKE_GENERATOR="Unix Makefiles"                                  				\
		-DCMAKE_TOOLCHAIN_FILE=${batch_file_path}/cmake_add/aarch64_qnx700.toolchain.cmake 	\
		-DCMAKE_BUILD_TYPE=Release															\
		${batch_file_path}
make -j16
cd ../../

