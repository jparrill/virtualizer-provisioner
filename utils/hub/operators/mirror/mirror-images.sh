#!/bin/bash

REGISTRY="registry.$(hostname):5000"

if [[ ! -f ${HOME}/.docker/config.json ]];then
        cp config.json ${HOME}/.docker/config.json
fi

oc-mirror --v2 --source-skip-tls --config imagesetconfig.yaml docker://${REGISTRY}
