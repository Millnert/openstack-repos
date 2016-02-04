#!/bin/bash

# Todo
# 1. Add check of installed programs (git, git-review)
# 2. Make sure git and git-review are configured
# 3. Add configuration of git-review for each checked-out repo

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

wait
echo ""
echo ""
echo "Checkout / Clone completed"
