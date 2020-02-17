#!/bin/bash

# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be auto generated for the account.
# The username, password, and host for the account will be displayed.


# Make sure the script is being executed with the superuser privileges.
if [[ "${UID}" -ne 0 ]]
  then
    echo 'Please run with sudo or as root.' >&2 /dev/null
    exit 1
fi

# If they dont supply at least on arg, then give them help.
if [[ "${#}" -lt 1 ]]
then 
  echo "Usage: ${0} USER_NAME [COMMENT]..." >&2 /dev/null
  exit 1
fi

# The first parameter is the user name
USER_NAME="${1}";

# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# Check to see if the useradd command succeeded.
# We do not want to tell the user that an account was created when it hasnt been.
if [[ "${?}" -ne 0 ]]
then 
  echo 'The account could not be created.' >&2 /dev/null
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null
passwd -e ${USER_NAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
  echo 'The password for the account could not be set.' >&2 /dev/null
  exit 1
fi

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0;
