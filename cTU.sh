#!/bin/bash

## 判断三次URL可用性
## 方法一：利用循环技巧，如果成功就跳出当前循环，否则执行到最后一行

check_url() {
    HTTP_CODE=$(curl -o /dev/null --connect-timout 3 -s -w "%{http_code}" $1)
    if [ $HTTP_CODE -eq 200 ]; then
        continue
    fi
}
URL_LIST="www.baidu.com www.agasgf.com"
for URL in URL_LIST; do
    check_url $URL
    check_url $URL
    check_url $URL
    echo "Warning: $URL Access failure"
done
