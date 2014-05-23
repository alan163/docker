#/bin/bash
#set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR/conf && tar zcf ../conf.tar.gz .
