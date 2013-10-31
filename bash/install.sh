#!/bin/sh

# Detect platform
ENV_CONFIG_PLATFORM='unknown'
if [[ ${OSTYPE} == darwin* ]]; then
	ENV_CONFIG_PLATFORM='darwin'
# Not tested
#elif [[ ${OSTYPE} == linux* ]]; then
#	ENV_CONFIG_PLATFORM='linux'
else
	echo "Error: unknown OS type \"${OSTYPE}\""
	exit 1
fi

# Process options
ENV_CONFIG_COLORS='yes'
ENV_CONFIG_DIR='~/.env-config'
ENV_CONFIG_VERBOSE='no'
ENV_CONFIG_DRYRUN='no'
while getopts ":hvyc:d:" opt; do
	case ${opt} in
		h)
			echo "Options are:"
			echo "    -h          - show this help"
			echo "    -v          - verbose output"
			echo "    -y          - dry run"
			echo "    -c (yes|no) - enable colors (default is ${ENV_CONFIG_COLORS})"
			echo "    -d <dir>    - install to dir (default is \"${ENV_CONFIG_DIR}\")"
			exit 1
			;;
		v)
			ENV_CONFIG_VERBOSE='yes'
			;;
		y)
			ENV_CONFIG_DRYRUN='yes'
			;;
		c)
			if [[ ${OPTARG} != 'yes' && ${OPTARG} != 'no' ]]; then
				echo "Error: invalid value ${OPTARG} for option -c"
				exit 1
			fi
			ENV_CONFIG_COLORS=${OPTARG}
			;;
		d)
			ENV_CONFIG_DIR=${OPTARG}
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
eval DST_DIR=${ENV_CONFIG_DIR}
DST_BASHRC=${DST_DIR}/bashrc
SRC_DIR=$(dirname "${BASH_SOURCE[0]}")

if [[ ${ENV_CONFIG_VERBOSE} == 'yes' ]]; then
	echo "colors:   \"${ENV_CONFIG_COLORS}\""
	echo "dryrun:   \"${ENV_CONFIG_DRYRUN}\""
	echo "platform: \"${ENV_CONFIG_PLATFORM}\""
	echo "dir:      \"${ENV_CONFIG_DIR}\" (\"${DST_DIR}\")"
	echo "src:      \"${SRC_DIR}\""
fi

if [[ ${ENV_CONFIG_DRYRUN} == 'no' ]]; then
	mkdir -p "${DST_DIR}" || exit 1
	sed \
		-e "s;^#ENV_CONFIG_PLATFORM=.*;ENV_CONFIG_PLATFORM=\'${ENV_CONFIG_PLATFORM}\';" \
		-e "s;^#ENV_CONFIG_COLORS=.*;ENV_CONFIG_COLORS=\'${ENV_CONFIG_COLORS}\';" \
		-e "s;^#ENV_CONFIG_DIR=.*;ENV_CONFIG_DIR=\'${ENV_CONFIG_DIR}\';" \
		"${SRC_DIR}/bashrc" > ${DST_DIR}/bashrc
fi

if [[ ${ENV_CONFIG_PLATFORM} == 'darwin' ]]; then
	DST_SOURCE='~/.bash_profile'
elif [[ ${ENV_CONFIG_PLATFORM} == 'linux' ]]; then
	DST_SOURCE='~/.bashrc'
fi

echo ""
echo "Add the following line to your \"${DST_SOURCE}\":"
echo "source ${ENV_CONFIG_DIR}/bashrc"
