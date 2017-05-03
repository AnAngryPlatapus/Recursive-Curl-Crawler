#!/bin/bash

#The big Dumb Curl WebCrawler, init script
#
#By Sam Miller


mysite="$1"

if [ !$(grep -Fxq "$mysite" goodlinks) ] && [ $mysite != "stop" ]
then
	curl -s "$mysite" | sed -ne 's/.*\(http[^"]*\).*/\1/p' >> queue

	echo "Queue size:"
	wc -l queue | tee -a qcount
	echo "Link Number:" 
	wc -l goodlinks | tee -a lcount
	
	

	if [[ $(echo $qcount) -gt 10 ]] 
	then 
		echo "stop" >> queue
	fi

	./recSearch.sh
fi
