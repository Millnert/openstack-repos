#!/bin/bash

# https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches
for repourl in `grep -vE '^#' repos.txt` ; do
	reponame=`echo $repourl | sed -e 's/.*\/\(.*\)\.git$/\1/g'`
	echo "Repository: $reponame ( $repourl )"
	if [ ! -d ${reponame} ]; then
		(git clone $repourl && echo "Clone of $reponame completed OK!" || echo "Clone of $reponame NOT OK!" &)
	elif [ -f ${reponame}/.git/config ]; then
		(cd $reponame && git pull --all && echo "Pull of $reponame OK" || echo "Pull of $reponame NOT OK!" &)
	else
		echo "Something is strange with $reponame - please investigate!"
	fi
done
