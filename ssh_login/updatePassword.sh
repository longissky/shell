#!/bin/bash
username=root
preHost=10.243.8.
port=22
cmd="echo 'newpwd'| passwd --stdin root;exit"
pwd=oldpwd
# 可以将需要修改的ip作为参数传入
for((i=103;i<=103;i++));
do
	./login.sh "$username" "$preHost$i" "$port" "$cmd" "$pwd"
done



