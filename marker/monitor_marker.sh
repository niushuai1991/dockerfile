#!/bin/bash

API_URL="http://127.0.0.1:80/marker/upload"
FILE_PATH="/opt/sample.pdf"
# Waiting for the service to run
while true
do
    # 使用curl获取HTTP状态码
    status_code=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:80)
    if [ "$status_code" -eq 200 ]; then
        break
    else
        sleep 10
    fi
done

while true; do
  http_code=$(curl -o /dev/null -s -w "%{http_code}" -F "file=@$FILE_PATH" "$API_URL")
  if [[ $http_code == *"500"* ]]; then
      echo "$(date +"%Y-%m-%d %H:%M:%S") Marker service detected 500 error, ready to close..."
      kill $(pidof python)
  fi
  sleep 120
done