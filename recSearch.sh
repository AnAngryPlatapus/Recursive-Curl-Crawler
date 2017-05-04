#!/bin/bash

#curl the first line in text file
#if works add link to final link list
#add links of list to queue
set -x
while read line
do

	size=$(wc -l $queue)
	echo Size of q "$size"
	if [ $size -gt 1000 ]
	then
		./clean
		break 1
	fi

	url=$(echo $line)
	curl -s "$url" --stderr 0 > log
	if [ $? -eq 0 ] && [ !$(grep -Fxq "$url" goodlinks) ]
	then
		echo "$url" >> goodlinks
		sed -i '1d' queue
		./init.sh "$url"
	fi
	sed -i '1d' queue

done < queue
