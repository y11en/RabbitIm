#参数:
#    $1:源码的位置 


#运行本脚本前,先运行 build_unix_envsetup.sh 进行环境变量设置,需要先设置下面变量:
#   PREFIX=`pwd`/../unix  #修改这里为安装前缀
if [ -z "${PREFIX}" ]; then
    echo "build_unix_envsetup.sh"
    source build_unix_envsetup.sh
fi

if [ -n "$1" ]; then
    SOURCE_CODE=$1
else
    SOURCE_CODE=${PREFIX}/../src/speexdsp
fi

#下载源码:
if [ ! -d ${SOURCE_CODE} ]; then
    echo "git clone http://git.xiph.org/speexdsp.git  ${SOURCE_CODE}"
    git clone http://git.xiph.org/speexdsp.git  ${SOURCE_CODE}
fi

CUR_DIR=`pwd`
cd ${SOURCE_CODE}

echo ""
echo "SOURCE_CODE:$SOURCE_CODE"
echo "CUR_DIR:$CUR_DIR"
echo "PREFIX:$PREFIX"
echo ""

if [ ! -f configure ]; then
    echo "source autogen.sh"
    source autogen.sh 
fi

mkdir -p build_unix
cd build_unix
rm -fr *

echo "configure ..."
../configure --prefix=$PREFIX  \
    --disable-shared \
    --enable-static \
    --disable-examples
    
echo "make install"
make -j 2
make install

cd $CUR_DIR
