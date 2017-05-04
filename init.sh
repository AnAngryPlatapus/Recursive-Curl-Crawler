#!/bin/bash

#The big Dumb Curl WebCrawler, init script
#
#By Sam Miller

mysite="$1"

if [ !$(grep -Fxq "$mysite" goodlinks) ]
then
	curl -s "$mysite" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' >> queue

	echo "Queue size:"
	wc -l queue | tee -a  qcount
	echo "Links scraped:"
	wc -l goodlinks | tee -a lcount

	./recSearch.sh

fi
