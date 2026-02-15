#!/bin/zsh
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file missing"
    exit 1
fi

USER=${CHTC_USER}
HOSTNAME="ap2001.chtc.wisc.edu"
ssh ${USER}@${HOSTNAME}