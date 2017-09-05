#!/bin/bash
username=root
preHost=10.243.8.
port=22
cmd="echo 'newpwd'| passwd --stdin root;exit"
pwd=oldpwd

for((i=103;i<=103;i++));
do
	./login.sh "$username" "$preHost$i" "$port" "$cmd" "$pwd"
done



