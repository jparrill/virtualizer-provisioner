#!/bin/bash

BASE_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TEMPLATE_FOLDER=${BASE_PATH}/templates
MC_ICSP_TEMPLATE=${TEMPLATE_FOLDER}/mc-icsp.template.yaml
MC_ICSP_RAW_FILE=${TEMPLATE_FOLDER}/icsp-raw-mc.template.yaml
ICSP_MCE_DOWNSTREAM_TEMPLATE=${TEMPLATE_FOLDER}/icsp.template.yaml
REGULAR_ICSP_OUTFILE=${BASE_PATH}/mce-icsp.yaml
MC_ICSP_OUTFILE=${BASE_PATH}/mce-mc-icsp.yaml

export PRIVATE_REGISTRY=${REGISTRY:-registry.$(hostname --long):5000}
## Generate MC Raw file

export B64_RAWICSP=$(envsubst < ${MC_ICSP_RAW_FILE} | base64 -w0)

envsubst < ${MC_ICSP_TEMPLATE} > ${MC_ICSP_OUTFILE}
envsubst < ${ICSP_MCE_DOWNSTREAM_TEMPLATE} > regular-mce-icsp.yaml
