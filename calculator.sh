#!/bin/bash

RESULT=a
NUMTURN=1
NUM1=a
OLDNUM=$NUM1
OPERATOR=0
END=:q

while [ "$NUM1" != "$END" ] && [ "$OPERATOR" != "$END" ] ; do
	if (( $NUMTURN==1  )) ; then
		read -p "Please insert a number: " NUM1 
		if (( ${#NUM1}<1 )) ; then
			echo -n "Error! "
			continue
		elif [ "$NUM1" = ":q" ] ; then
			continue
		fi
		case $NUM1 in
			*[!0-9]*) echo -n "Error! " ;;
			*) NUMTURN=0
			   if [ "$OPERATOR" != "0" ] ; then
				if [ "$RESULT" = "a" ] ; then
					RESULT=$(( $OLDNUM${OPERATOR}$NUM1 ))
				else
					RESULT=$(( $RESULT${OPERATOR}$NUM1 ))
				fi
				echo Result so far is: $RESULT
			   fi
			   OLDNUM=$NUM1 ;;
		esac
	else
		read -p "Please insert an operator: " OPERATOR 
		if (( ${#OPERATOR}<1 )) ; then
			echo -n "Error! "
			continue
		elif [ "$OPERATOR" = ":q" ] ; then
			continue
		fi
		if [ "$OPERATOR" = "+" ] || [ "$OPERATOR" = "-" ] || [ "$OPERATOR" = "/" ] || [ "$OPERATOR" = "*" ] ; then
			NUMTURN=1
		else
			echo -n "Error! "
		fi
	fi
done
echo Thanks for using my calculator
