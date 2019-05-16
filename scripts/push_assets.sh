#!/bin/bash

# Pull Assets
#
# Pull remote assets down from a remote to local
#
# @author    nystudio107
# @copyright Copyright (c) 2017 nystudio107
# @link      https://nystudio107.com/
# @package   craft-scripts
# @since     1.1.0
# @license   MIT

# Get the directory of the currently executing script
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Include files
INCLUDE_FILES=(
            "common/defaults.sh"
            ".env.sh"
            "common/common_env.sh"
            )
for INCLUDE_FILE in "${INCLUDE_FILES[@]}"
do
    if [[ ! -f "${DIR}/${INCLUDE_FILE}" ]] ; then
        echo "File ${DIR}/${INCLUDE_FILE} is missing, aborting."
        exit 1
    fi
    source "${DIR}/${INCLUDE_FILE}"
done


# Loop through local dirs and upload using scp
for DIR in "${LOCAL_ASSETS_DIRS[@]}"
do
    # scp -P $REMOTE_SSH_PORT "${LOCAL_ASSETS_PATH}${DIR}" $REMOTE_SSH_LOGIN:"${REMOTE_ASSETS_PATH}"
    rsync -avzhe ssh "${LOCAL_ASSETS_PATH}${DIR}"  ${REMOTE_SSH_LOGIN}:"${REMOTE_ASSETS_PATH}"
    echo "*** Synced assets from ${REMOTE_ASSETS_PATH}${DIR}"
done


# Normal exit
exit 0
