#!/bin/bash

#curl the first line in text file
#if works add link to final link list
#add links of list to queue


while read line
do 
	url=$(echo $line)	
	curl -s "$url" --stderr 0 > log 
	if [ $? -eq 0 ] && [ !$(grep -Fxq "$url" goodlinks) ]
	then 
		echo "$url" >> goodlinks
		sed -i '1d' queue
		./init.sh "$url" 

	elif [ `( cat $(echo "$count") )` -gt 20 ]
	then
		break 3
	fi

done < queue 



