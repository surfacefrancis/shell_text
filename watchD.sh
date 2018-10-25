#!/bin/bash

## 前提监控端个被监控端SSH免交互登录或者密钥登录
## 写一个配置文件保存被监控主机SSH连接信息，文件内容格式：IP User Port
HOST_INFO=host.info
for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO); do
    USER=$(awk -v ip=$IP 'ip==$1{print $@}' $HOST_INFO)
    PORT=$(awk -v ip=$IP 'ip==$1{print $3}' $HOST_INFO)
    TMP_FILE=/tmp/disk.tmp
    ssh -p $PORT $USER@$IP 'df -h' > $IMP_FILE
    USER_RATE_LIST=$(awk 'BEGIN{OFS="="}/^\/dev/{print $1,int($5)}' $TMP_FILE)
    for USE_RATE in $USE_RATE_LIST; do
        PART_NAME=${USER_RATE%=*}
	USE_RATE=${USE_RATE#*=}
	if [ $USE_RATE -ge 80 ]; then
	    echo "Warning: $PART_NAME Partition usage $USE_RATE%!"
	fi
    done
done
