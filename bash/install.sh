#!/bin/sh

# Detect platform
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

# Process options
colors="yes"
dstdir="~/.bash"
while getopts ":hc:d:" opt; do
	case $opt in
		h)
			echo "Options are:"
			echo "    -h          - show this help"
			echo "    -c (yes|no) - enable colors (default is ${colors})"
			echo "    -d <dir>    - install to dir (default is \"${dstdir}\")"
			exit 1
			;;
		c)
			colors=${OPTARG}
			if [[ ${colors} != "yes" && ${colors} != "no" ]]; then
				echo "Error: invalid value ${colors} for option -c"
				exit 1
			fi
			;;
		d)
			dstdir=${OPTARG}
			;;
		\?)
			echo "Error: invalid option -${OPTARG}"
			exit 1
			;;
		:)
			echo "Error: option -${OPTARG} requires an argument"
			exit 1
			;;
	esac
done

# Context
echo "Platform: \"${platform}\""
echo "Colors: \"${colors}\""
echo "Dir: \"${dstdir}\""

if [[ $platform == 'darwin' ]]; then
	alias ls="ls -G"
	alias grep='grep --color=auto'
fi
