#!/bin/sh

platform='unknown'
if [[ ${OSTYPE} == darwin* ]]; then
	platform='darwin'
# Not tested
#elif [[ ${OSTYPE} == linux* ]]; then
#	platform='linux'
else
	echo "Error: unknown OS type \"${OSTYPE}\""
	exit 1
fi
echo "Platform: \"${platform}\""
