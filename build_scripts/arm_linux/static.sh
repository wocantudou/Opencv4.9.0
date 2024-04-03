#/bin/sh

cd ../../

if [ ! -f "cmake_build" ];then
	mkdir cmake_build
fi

CMAKE=cmake
batch_file_path=$(pwd)
echo "${batch_file_path}"

cd cmake_build
PLATFORM_BUILD_PATH="./cmake_build_arm_lin32"
if [ ! -f "$PLATFORM_BUILD_PATH" ]; then
	mkdir $PLATFORM_BUILD_PATH
fi
cd $PLATFORM_BUILD_PATH

cmake	-DBUILD_EXAMPLES=ON																	\
		-DWITH_FFMPEG=OFF																	\
		-DBUILD_SHARED_LIBS=ON																\
		-DBUILD_LIST=calib3d,videoio														\
		-DCMAKE_GENERATOR="Unix Makefiles"                                  				\
		-DCMAKE_TOOLCHAIN_FILE=${batch_file_path}/cmake_add/arm_linux.toolchain.cmake 		\
		-DCMAKE_BUILD_TYPE=Release															\
		${batch_file_path} 

make -j16
cd ../../

