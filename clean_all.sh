#!/bin/bash

# https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches
for repourl in `grep -vE '^#' repos.txt` ; do
	reponame=`echo $repourl | sed -e 's/.*\/\(.*\)\.git$/\1/g'`
	echo "Repository: $reponame ( $repourl )"
	if [ -d ${reponame} ]; then
		rm -rf ${reponame}
	fi
done
