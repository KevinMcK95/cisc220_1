#!/bin/bash

fullList=$(ifconfig)
fullList=( ${fullList[*]}  )


declare -a ip
ip=( )
ipTitle="inet addr:"
inet="inet"
addr="addr:"

for i in $(seq 0 ${#fullList[*]}) ; do
	string=${fullList[$i]}
	nextIndex=$(($i+1))
	nextString=${fullList[$nextIndex]}
	testString="$string $nextString"
	if [ "${testString:0:10}" = "$ipTitle" ] ; then #if the name looks like "inet addr:NUMBER" as it does on my linux machine
		ip+=( ${testString:10:${#nextString}} )
	fi
done

for add in ${ip[*]} ; do
	echo -n "$add "
	if [[ $add == 127* ]] ; then
		echo Local IP
	elif [[ $add == 10* ]] ; then
		echo Private IP
	elif [[ $add == 192.168* ]] ; then
		echo Private IP
	else
		echo Public IP
	fi
done
