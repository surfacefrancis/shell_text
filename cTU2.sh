#!/bin/bash
## 错误次数报讯到变量中
URL_LIST="www.baidu.com www.agasgf.com"
for URL in $URL_LIST; do
    FAIL_COUNT=0
    for ((i=1;i<=3;i++)); do
	HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $URL)
            if [ $HTTP_CODE -ne 200 ]; then
	        let FAIL_COUNT++
	    else
		break
	    fi
	done
	if [ $FAIL_COUNT -eq 3 ]; then
	    echo "Warning: $URL Access failure!"
	fi
done
