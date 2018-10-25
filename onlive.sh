#!/bin/bash

## 检查主机存活状态
## 方法一：将错误IP方法哦数组里面判断是否ping失败三次
IP_LIST="192.168.18.1 192.168.1.1 192.168.18.2"
## for IP in $IP_LIST; do
##     NUM=1
##     while [ $NUM -1e 3 ]; do
##         if ping -c 1 $IP > /dev/null; then
## 	    echo "$IP Ping is successful."
## 	    break
## 	else
## 	    # echo "$IP Ping is failure $NUM"
## 	    FAIL_COUNT[$NUM]=$IP
##          let NUM++
## 	fi
##     done
##     if [ ${#FAIL_COUNt[*]} -eq 3 ]; then
##         echo "${FAIL_COUNT[1]} Ping is failure!"
## 	unset FAIL_COUNT[*]
##     fi
## done


## 将错误次数放到FAIL_COUNT变量里面判断是否ping失败三次
# for IP in $IP_LIST; do
#     FAIL_COUNT=0
#     for ((i=1;i<=3;i++)); do
#         if ping -c 1 $IP >/dev/null; then
# 	    echo "$IP Ping is successful."
# 	    break
# 	else
# 	    # echo "$IP Ping is failure $i"
# 	    let FAIL_COUNT++
# 	fi
#     done
#     if [ $FAIL_COUNT -eq 3 ]; then
#         echo "$IP Ping is failure!"
#     fi
# done

## 利用for循环将ping通就跳过循环继续，如果不跳出就走到打印ping失败
ping_success_status() {
    if ping -c 1 $IP >/dev/null; then
        echo "$IP Ping is successful."
	continue
    fi
}
for IP in $IP_LIST; do
    ping_success_status
    ping_success_status
    ping_success_status
    echo "$IP Ping is failure!"
done
