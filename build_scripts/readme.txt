
############20200818
1、本文件夹下支持多个平台的构建编译，可以更具不同平台选择进行编译；
2、整个工程是通过cmake进行构建的，构建编译之前请确认支持3.10.x以上版本的cmake；
3、编辑编译脚本可以设置不同的编译参数选择不同的编译条件，例如如果需要支持python接口，请确保支持安装python3，并设置编译脚本中的-DBUILD_PYTHON=ON
4、sh xxx.sh直接进行构建编译
5、编译成功后,会生成../../BuildTarget,此文件夹就是一个大包好的引擎，cd ../../BuildTarget/bin/{对应平台}，运行相应的命令


#define ENGINE_NAME iflyDSMRuntime_shared_ifri
#define ENGINE_VERSION_MAJOR 3.1
#define ENGINE_VERSION_MINOR 1005
#define ENGINE_VERSION_PATCH 0

