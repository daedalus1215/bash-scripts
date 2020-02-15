#!/bin/bash

# Only can be executed by superuser
# If not superuser, then exit with a status of 1
USER_ID=$(id $USER -u)
if [[ "$USER_ID" -ne 0 ]]
then
  echo "need to be root"
  exit 1
fi

USER_LOGIN_NAME=${1};

# if the user does not supply an account name on the command line, 
 # then, provide a usage statement,
 # then return an exist status of 1
if [[ "${#}" -lt 1 ]] 
then 
  echo "Need to provide a [USER_NAME] when trying to create a user account"
  exit 1
fi


# If the account is not created,
 # Script returns status 1
  # and we inform the user
$(adduser $USER_LOGIN_NAME)

if [[ "${?}" -ne 0 ]]
then 
  echo "Error adding user ${USER_LOGIN_NAME}. Look up error code ${?}";
  exit 1;
fi

# Auto generate a password for the new account
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c36);
RANDOM_SPECIAL_CHARACTER='!@#$%^&*()_-+=' |shuf |  fold -w 1 | shuf | head -n 1;
FINAL_RANDOM_PASSWORD=${PASSWORD}${RANDOM_SPECIAL_CHARACTER};
echo $FINAL_RANDOM_PASSWORD | passwd --stdin $USER_LOGIN_NAME;
# Display the username, password, and host (where the account was created)
echo "Successfully created an account for username: ${USER_LOGIN_NAME}, with a password of: ${FINAL_RANDOM_PASSWORD} on host: $(hostname)";


