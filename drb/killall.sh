#!/bin/bash
ps -ef|grep ruby|grep -v grep|awk '{print $2}'|while read line
do
echo $line
kill $line && echo "kill $line OK"
done
