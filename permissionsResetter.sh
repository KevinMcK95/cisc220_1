#!/bin/bash


if ! [ -f $2 ] ; then
	echo Error! $2 does not exist in this directory.
else
	first=true
	newList=$(ls -Rl $PWD)
	newList=( ${newList[*]} )
	oldList=$(cat $2)
	oldList=( ${oldList[*]} )
	for i in $(seq 0 2 $((${#oldList[*]}-1)) ) ; do
		oldPerm=${oldList[$i]}
		oldName=${oldList[$(($i+1))]}
		reset=1
		val=0
		binString=0
		for k in $(seq 1 $((${#oldPerm}-1)) ) ; do
			letter=${oldPerm:$k:1}
			if [ "$letter" = "r" ] ; then
				val=$(($val+4))
			elif [ "$letter" = "w" ] ; then
				val=$(($val+2))
			elif [ "$letter" = "x" ] ; then
				val=$(($val+1))
			fi
			if (( $reset == 3 )) ; then
				binString+=$val
				reset=1
				val=0
			else
				reset=$(($reset+1))
			fi
		done
		path="."
		for j in $(seq 1 $((${#newList[*]}-8)) ) ; do
			if [ "${newList[$j]:$((${#newList[$j]}-1))}" = ":" ] ; then
				pathString=${newList[$j]}
				pathString=${pathString:0:$((${#pathString[*]}-2))}
				path=$pathString/
			fi
			newPerm=${newList[$j]}
			newName=${newList[$(($j+8))]}
			if [ "$newName" = "$oldName" ] && [ "$newPerm" != "$oldPerm" ] ; then
				if [ "$1" = "-s" ] ; then
					if [ "$first" = "true" ] ; then
						echo "Old           Current       File"
						first=false
					fi
					echo "$oldPerm    $newPerm    $oldName"
				elif [ "$1" = "-r" ] ; then
					if [ "$path" = "." ] ; then
						chmod ${binString:1} $newName
					else
						chmod ${binString:1} $path$newName
					fi
					echo $oldName permissions reset from $newPerm to $oldPerm
				else
					if [ "$first" = "true" ] ; then
						echo "Error! Provided argument, '$1', is not '-r' or '-s'. Try again."
						first=false
						break
					fi
				fi
			fi
		done
	done
fi
