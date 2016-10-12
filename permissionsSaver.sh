#!/bin/bash

fullList=$(ls -Rl $PWD)
fullList=( ${fullList[*]} )

count=1
if [ -f savedPermissions ] ; then
	while [ -f savedPermissions$count ] ; do
		count=$(($count+1))
	done
	saveFile=savedPermissions$count
else
	saveFile=savedPermissions
fi

for i in $(seq 0 $((${#fullList[*]}-8))) ; do
	string="${fullList[$i]}"
	name="${fullList[$(($i+8))]}"
	firstChar=${string:0:1}
	if (( ${#string}==10 )) && [ "$firstChar" = "-" ] ; then
	for j in $(seq 1 $((${#string}-1)) ) ; do
		substring=${string:$(($j)):1}
		
		if (( $(($j%3))==1 )) && [ "$substring" != "r" ] && [ "$substring" != "-" ] ; then
			break
		elif (( $(($j%3))==2 )) && [ "$substring" != "w" ] && [ "$substring" != "-" ] ; then
			break
		elif (( $(($j%3))==0 )) && [ "$substring" != "x" ] && [ "$substring" != "-" ] ; then
			break
		fi
		if (( $j==$((${#string}-1)) )); then #reached the end without breaking
			echo $string $name >> $saveFile
		fi
	done
	fi
done

echo $saveFile created!
