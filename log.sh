#!/bin/bash

function log() {
  local VERBOSE="${1}"
  if [[ "${VERBOSE}" == 'true' ]]
  then
    shift 
    local MESSAGE="${@}"
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

readonly VERBOSE='true'
log VERBOSE 'YES!'




