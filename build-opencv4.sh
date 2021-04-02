#!/usr/bin/env bash
# build opencv 4.5.x base on https://github.com/nihui/opencv-mobile/blob/master/opencv4_cmake_options.txt

function cmakeParams(){
    mkdir -p "build-$1"
    pushd "build-$1"
    cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_CONFIGURATION_TYPES=$1\
    -DOpenMP_C_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include" \
    -DOpenMP_CXX_FLAGS="-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include" \
    -DOpenMP_CXX_LIB_NAMES="omp" \
    -DOpenMP_C_LIB_NAMES="omp" \
    -DCMAKE_INSTALL_PREFIX=install \
    -DBUILD_ZLIB=OFF \
    -DBUILD_TIFF=ON \
    -DBUILD_OPENJPEG=ON \
    -DBUILD_JASPER=ON \
    -DBUILD_JPEG=ON \
    -DBUILD_PNG=ON \
    -DBUILD_OPENEXR=ON \
    -DBUILD_WEBP=ON \
    -DBUILD_TBB=OFF \
    -DBUILD_IPP_IW=OFF \
    -DBUILD_ITT=OFF \
    -DWITH_AVFOUNDATION=OFF \
    -DWITH_CAP_IOS=OFF \
    -DWITH_CAROTENE=OFF \
    -DWITH_CPUFEATURES=OFF \
    -DWITH_EIGEN=OFF \
    -DWITH_FFMPEG=OFF \
    -DWITH_GSTREAMER=OFF \
    -DWITH_GTK=OFF \
    -DWITH_IPP=OFF \
    -DWITH_HALIDE=OFF \
    -DWITH_VULKAN=OFF \
    -DWITH_INF_ENGINE=OFF \
    -DWITH_NGRAPH=OFF \
    -DWITH_JASPER=ON \
    -DWITH_OPENJPEG=ON \
    -DWITH_JPEG=ON \
    -DWITH_WEBP=ON \
    -DWITH_OPENEXR=ON \
    -DWITH_PNG=ON \
    -DWITH_TIFF=ON \
    -DWITH_OPENVX=OFF \
    -DWITH_GDCM=OFF \
    -DWITH_TBB=OFF \
    -DWITH_HPX=OFF \
    -DWITH_OPENMP=ON \
    -DWITH_PTHREADS_PF=OFF \
    -DWITH_V4L=OFF \
    -DWITH_CLP=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENCL_SVM=OFF \
    -DWITH_ITT=OFF \
    -DWITH_PROTOBUF=OFF \
    -DWITH_IMGCODEC_HDR=OFF \
    -DWITH_IMGCODEC_SUNRASTER=OFF \
    -DWITH_IMGCODEC_PXM=OFF \
    -DWITH_IMGCODEC_PFM=OFF \
    -DWITH_QUIRC=OFF \
    -DWITH_ANDROID_MEDIANDK=OFF \
    -DWITH_TENGINE=OFF \
    -DWITH_ONNX=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_opencv_apps=OFF \
    -DBUILD_ANDROID_PROJECTS=OFF \
    -DBUILD_ANDROID_EXAMPLES=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_PACKAGE=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_FAT_JAVA_LIB=OFF \
    -DBUILD_ANDROID_SERVICE=OFF \
    -DBUILD_JAVA=OFF \
    -DBUILD_OBJC=OFF \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DENABLE_FAST_MATH=OFF \
    -DCV_TRACE=OFF \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_gapi=OFF \
    -DBUILD_opencv_objc=OFF \
    -DBUILD_opencv_js=OFF \
    -DBUILD_opencv_ts=OFF \
    -DBUILD_opencv_python2=OFF \
    -DBUILD_opencv_python3=OFF \
    -DBUILD_opencv_dnn=OFF \
    -DBUILD_opencv_imgcodecs=ON \
    -DBUILD_opencv_videoio=OFF \
    -DBUILD_opencv_calib3d=OFF \
    -DBUILD_opencv_flann=OFF \
    -DBUILD_opencv_objdetect=OFF \
    -DBUILD_opencv_stitching=OFF \
    -DBUILD_opencv_ml=OFF \
    ..
    cmake --build . -j $NUM_THREADS
    cmake --build . --target install
    popd
}

sysOS=`uname -s`
NUM_THREADS=1
if [ $sysOS == "Darwin" ];then
    #echo "I'm MacOS"
    NUM_THREADS=$(sysctl -n hw.ncpu)
elif [ $sysOS == "Linux" ];then
    #echo "I'm Linux"
    NUM_THREADS=$(grep ^processor /proc/cpuinfo | wc -l)
else
    echo "Other OS: $sysOS"
fi

cmakeParams "Release"
