#!/bin/bash

# a script that will accept a file as a command line argument and 
# check if the file is executable or writable, and prints a cerain message accordingly

if [ -e $1 ] 
then
	
	if [ -w $1 ]
	then
		echo "The file is writable"
	fi
	
	if [ -x $1 ]
	then
		echo "The file is executable"
	fi
else
	echo "The file does not exist"
fi
