#!/bin/bash

REGISTRY="registry.$(hostname):5000"

mkdir -p ${HOME}/.docker

if [[ ! -f ${HOME}/.docker/config.json ]];then
        cp config.json ${HOME}/.docker/config.json
fi

if [[ ! -f $(pwd)/imagesetconfig.yaml ]];then
        echo "imagesetconfig.yaml not found"
        exit 1
fi

mkdir -p workspace
ooc-mirror --config imagesetconfig.yaml --workspace file://$(pwd)/workspace docker://${REGISTRY} --v2