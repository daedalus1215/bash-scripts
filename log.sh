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


function backup_file() {
  # This function created a backup of a file. Returns non-zero status on error.
  
  local FILE="${1}"

  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
    then
      local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
      log true "Backing up ${FILE} to ${BACKUP_FILE}."

      # The exit status of the func will be the exit status of the cp command.
      cp -p ${FILE} ${BACKUP_FILE}
    else 
      # The file does not exist, so return a non-zero exit status.
      return 1
    fi
}


backup_file '/etc/passwd';





