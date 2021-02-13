#!/bin/bash
# a script which will print the numbers 1 - 10 (each on a separate line)
# and prints whether they are even or odd.

for number in {1..10}
do
	if [ $((number % 2)) -eq 0 ]
	then
		echo "$number : even"
	else
		echo "$number :  odd"
	fi
done
