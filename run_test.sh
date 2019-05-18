#!/usr/bin/env bash

for i in 1 2 3 4 5 6 7 8 9 0
do
  echo ==== ${i}
#  curl -s jenkins:8080  | grep "Authentication required" && exit 0
  curl jenkins:8080 -D -
  sleep 10
done

echo timeout
exit 1


