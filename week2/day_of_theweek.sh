#!/bin/bash

# a scrpt which will print a message upon which day of the week it is.

day=$1

case $day in
	monday)
		echo "It is Monday again!!"
	;;
	tuesday)
		echo "At least is is Tuesday"
	;;
	wednesday)
		echo "Half way to the weekend"
	;;
	Thursday)
		echo "A blessed Tursday"
	;;
	Friday)
		echo "TGIF"
	;;
esac
