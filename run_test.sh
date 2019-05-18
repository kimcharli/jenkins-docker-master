#!/usr/bin/env bash


for i in $(seq 1 ${RUNTESTRUNS})
do
  sleep ${RUNTESTSLEEP}

  echo ==== loop ${i} at $(date)
  curl -sS -D - jenkins:8080 | grep "^HTTP"
  curl -s jenkins:8080  | grep "Authentication required" && exit 0

done

echo timeout
exit 1


