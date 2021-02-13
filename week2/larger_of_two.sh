#!/bin/bash

# a script which will take 2 numbers as a command line arguments.
# it will print to the screen the larger of the two numbers

if [ $1 -gt $2 ]
then
	echo "$1 is greater than $2"
elif [ $2 -gt $1 ]
then
	echo "$2 is greater than $1"
else
	echo "They are equal"
fi
