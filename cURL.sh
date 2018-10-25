#!/bin/bash

## 检查URL可用性
## check_url(){
##     HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)
##     if [ $HTTP_CODE -ne 200 ]; then
##         echo "Warnig $1 Access failure"
##     fi
## }

check_url() {
    if ! uget -T 10 --tries=1 --spider $1 >/dev/null 2>&1; then
    # -T超过时间， --tries尝试第一次， --spider爬虫模式
        echo "Warning: $1 Access failure!"
    fi
}
