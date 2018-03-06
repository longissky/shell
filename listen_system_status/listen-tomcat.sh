#!/bin/bash
export DEPLOY_CONTAINER='/export/devcloud'
export LISTEN_URL='http://devcloud.xilexuan.com/devcloud/jsp/account/home_page.jp'
while true
do
	# check system status per 10s
	sleep 10
	httpCode=`curl -I -m 10 -o /dev/null -s -w %{http_code} $LISTEN_URL`
	echo "test $httpCode"
	if test $httpCode == 200 
	then 
	# 200 system status is ok
		continue
	elif test $httpCode == 000
	then
		# 000 network is not connected
		echo "network is not connected"
		continue
	else
	# other codes mean system is not runnable,deal by some methods.for example, restart tomcat
		echo "http code is $httpCode" 
		#get container process status
		pCount=`ps -ef|grep "$DEPLOY_CONTAINER/bin/bootstrap.jar" |grep -v $0|grep -v 'grep' | wc -l`
		if test $pCount == 0
		then
			echo "container $DEPLOY_CONTAINER not exists....."
		elif test $pCount == 1
		then
			echo "$DEPLOY_CONTAINER is running....."
			#kill process
			kill -9 `ps -ef | grep $DEPLOY_CONTAINER | grep -v 'grep' | grep -v $0 | awk '{print $DEPLOY_CONTAINER}'`
			#wait for container stopped
			while true
			do
				if test `ps -ef|grep $DEPLOY_CONTAINER |grep -v $0|grep -v 'grep' | wc -l` == 0
				then
				        break
				else
				        echo "waiting $DEPLOY_CONTAINER stop....."
				        sleep 1
				fi
			done
		else
			#exception needs to be resolved
			echo "$DEPLOY_CONTAINER is not the only one, shell executes fail"
			continue
		fi
	fi
	$DEPLOY_CONTAINER/bin/startup.sh
	count=0
	maxCount=10
	while [ $count -lt $maxCount ]
	do
		httpCodeStart=`curl -I -m 10 -o /dev/null -s -w %{http_code} $LISTEN_URL`
		if test $httpCodeStart == 200 
		then 
			break
		else
			echo "$DEPLOY_CONTAINER is not ok.....http code is $httpCodeStart...try $count times"
		fi
		let count++
	done
	# if count is up to max,give up waiting and log fail
	if test $count == $maxCount
	then
		echo "restart failed"
	else
		echo "restart success"
	fi
done
