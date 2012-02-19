typo3clone
==========

typo3clone is a small bash script to clone TYPO3 v4 from http://git.typo3.org and configure the new clone for contributions through https://review.typo3.org.

The script is inspired by the [TYPO3 git contribution walkthrough](http://wiki.typo3.org/Contribution_Walkthrough_with_CommandLine). It does not set your git username and email though.

Usage
-----

Just call `./typo3clone.sh`
The script will ask you for your typo3.org username to configure the review workflow. It will then create the clone in `./typo3_src-git/`.

Requirements
------------

The script was tested with git v1.7.9 and requires at least v1.7.8.

