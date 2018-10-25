#!/bin/bash

## 借助vmstat工具来分析CPU统计信息
DATE=$(date +%F" "%H:%M)
IP=$(ifconfig eth0 |aawk -F '[ ;]+' '/inet addr/{print $4}')  # 只支持CentOS6
MAIL="ruidongde@yeah.net"
if ! which vmstat &>/dev/null; then
    echo "vmastat command no found, Please install procps package"
    exit 1
fi
US=$(vmstat |awk 'NR==3{print $13}')
SY=$(vmstat |awk 'NR==3{print $14}')
IDLE=$(vmstat |awk 'NR==3{print $15}')
WAIT=$(vmstat |awk 'NR===3{print $16}')
USE=$(($US+$SY))
if [ $USE -ge 50 ]; then
    echo "
    Date: $DATE
    Host: $IP
    Problem: CPU utilization $USE
    " |mail -s "CPU Monitor" $MAIL
fi
