#!/usr/bin/env bash

# tested with git v1.7.9, requires at least v1.7.8

clear

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

# color echo http://www.faqs.org/docs/abs/HTML/colorizing.html

black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"


# Color-echo, Argument $1 = message, Argument $2 = color
cecho ()
{
	local default_msg="No message passed."

	# Defaults to default message.
	message=${1:-$default_msg}

	# Defaults to black, if not specified.
	color=${2:-$black}

	echo -e "$color$message"

	# Reset text attributes to normal + without clearing screen.
	tput sgr0

	return
}

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----


# hello
echo -e "Please enter your typo3.org username: \c "
read  T3O_USERNAME
cecho "Hi $T3O_USERNAME, starting to set up your TYPO3 clone." $green


# clone
git clone --recursive git://git.typo3.org/TYPO3v4/Core.git typo3_src-git
cd typo3_src-git


# set up hooks
cecho "Setting up TYPO3 commit message hook." $green
scp -p -P 29418 $T3O_USERNAME@review.typo3.org:hooks/commit-msg .git/hooks/

git submodule update --init
for module in $( ls .git/modules/typo3/sysext/ ); do
	cecho "Setting up EXT:$module commit message hook." $green
	scp -p -P 29418 $T3O_USERNAME@review.typo3.org:hooks/commit-msg .git/modules/typo3/sysext/$module/hooks/
done


# configure Gerrit
cecho "Configuring your clone to push to Gerrit" $green
git config --global url."ssh://$T3O_USERNAME@review.typo3.org:29418".pushInsteadOf git://git.typo3.org
git config --global branch.autosetuprebase remote


# k thx bye
cecho "All done, you're ready to go. Have fun!" $green

