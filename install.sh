#!/bin/sh

# Detect platform
ENV_CONFIG_PLATFORM='unknown'
if [[ ${OSTYPE} == darwin* ]]; then
	ENV_CONFIG_PLATFORM='darwin'
elif [[ ${OSTYPE} == linux* ]]; then
	ENV_CONFIG_PLATFORM='linux'
else
	echo "Error: unknown OS type \"${OSTYPE}\""
	exit 1
fi

# Options
ENV_CONFIG_DIR='~/.env-config'
ENV_CONFIG_COLORS='yes'
EC_SRC=$(dirname "${BASH_SOURCE[0]}")
EC_VERBOSE='no'
EC_DRYRUN='no'
while getopts ":hvyc:d:" OPT; do
	case ${OPT} in
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
			EC_VERBOSE='yes'
			;;
		y)
			EC_DRYRUN='yes'
			;;
		d)
			ENV_CONFIG_DIR=${OPTARG}
			;;
		c)
			if [[ ${OPTARG} != 'yes' && ${OPTARG} != 'no' ]]; then
				echo "Error: invalid value ${OPTARG} for option -c"
				exit 1
			fi
			ENV_CONFIG_COLORS=${OPTARG}
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

# Check install dir path
eval EC_DST=${ENV_CONFIG_DIR}
EC_DST_CHECK=$(printf '%q' "${ENV_CONFIG_DIR}")
if [[ ${EC_DST_CHECK} != ${ENV_CONFIG_DIR} ]]; then
	echo "Error: install dir \"${ENV_CONFIG_DIR}\" must not contain spaces, variables or other expandable tokens (except ~)"
	exit 1
fi
EC_DST_CHECK=${EC_DST_CHECK/#~/${HOME}}
if [[ ${EC_DST_CHECK} != ${EC_DST} ]]; then
	echo "Error: install dir \"${ENV_CONFIG_DIR}\" requires complex substitution that is not supported"
	exit 1
fi
if [[ ${EC_DST} != /* ]]; then
	echo "Error: install dir \"${ENV_CONFIG_DIR}\" doesn't evaluate to absolute path (\"${EC_DST}\")"
	exit 1
fi

if [[ ${EC_VERBOSE} == 'yes' ]]; then
	echo "src:      \"${EC_SRC}\""
	echo "dir:      \"${ENV_CONFIG_DIR}\" (\"${EC_DST}\")"
	echo "platform: \"${ENV_CONFIG_PLATFORM}\""
	echo "colors:   \"${ENV_CONFIG_COLORS}\""
	echo "dryrun:   \"${EC_DRYRUN}\""
fi

if [[ ${EC_DRYRUN} == 'no' ]]; then
	mkdir -p "${EC_DST}" || exit 1

	# bashrc - copy
	mkdir -p "${EC_DST}/bash" || exit 1
	sed \
		-e "s;^#ENV_CONFIG_PLATFORM=.*;ENV_CONFIG_PLATFORM=\'${ENV_CONFIG_PLATFORM}\';" \
		-e "s;^#ENV_CONFIG_COLORS=.*;ENV_CONFIG_COLORS=\'${ENV_CONFIG_COLORS}\';" \
		-e "s;^#ENV_CONFIG_DIR=.*;ENV_CONFIG_DIR=\'${ENV_CONFIG_DIR}\';" \
		"${EC_SRC}/bash/bashrc" > ${EC_DST}/bash/bashrc || exit 1

	# bashrc - source
	case ${ENV_CONFIG_PLATFORM} in
		'darwin') eval EC_BASHRC_FILE='~/.bash_profile';;
		'linux') eval EC_BASHRC_FILE='~/.bashrc1';;
		*) echo "Error: unknown platform ${ENV_CONFIG_PLATFORM}"; exit 1;;
	esac
	if ! grep -Fq "${ENV_CONFIG_DIR}" ${EC_BASHRC_FILE} &> /dev/null; then
		# ${ENV_CONFIG_DIR} was not found in ${EC_BASHRC_FILE}
		# It is OK to append init script.
		# If ${EC_BASHRC_FILE} not empty, append extra new line for extra style
		if [[ -s ${EC_BASHRC_FILE} ]]; then
			echo >> ${EC_BASHRC_FILE};
		fi
		sed \
			-e "s;\${ENV_CONFIG_DIR};${ENV_CONFIG_DIR};" \
			"${EC_SRC}/bash/bashrc-init" >> ${EC_BASHRC_FILE}
	fi
			
	# readline - copy
	mkdir -p "${EC_DST}/readline" || exit 1
	cp ${EC_SRC}/readline/inputrc ${EC_DST}/readline/inputrc

	# readline - source
	eval EC_READLINERC_FILE='~/.inputrc'
	if ! grep -Fq "${ENV_CONFIG_DIR}" ${EC_READLINERC_FILE} &> /dev/null; then
		# ${ENV_CONFIG_DIR} was not found in ${EC_READLINERC_FILE}
		# It is OK to append init script.
		# If ${EC_READLINERC_FILE} not empty, append extra new line for extra style
		if [[ -s ${EC_READLINERC_FILE} ]]; then
			echo >> ${EC_READLINERC_FILE};
		fi
		sed \
			-e "s;\${ENV_CONFIG_DIR};${ENV_CONFIG_DIR};" \
			"${EC_SRC}/readline/inputrc-init" >> ${EC_READLINERC_FILE}
	fi
fi

echo "Done!"
