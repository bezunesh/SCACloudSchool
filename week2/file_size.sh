#!/bin/bash
# A script that takes a single command line argument(a directory) and  will print each entry in that directory
# if the entry is a file it will print it's size
# if the entry is a directory it will print how many items are in that directory

for entry in $1/*
do
	#echo $entry
	if [ -f $entry ]
	then
		echo "$entry is a file"
		echo "It's size in Bytes is: $(wc -c $entry | awk '{print($1)}')"
	elif [ -d $entry ]; then
		echo "$entry is a directory"
		echo "It has $(ls -1 $entry | wc -l) items inside it."
	fi

done
