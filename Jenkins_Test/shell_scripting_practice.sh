#!/bin/bash

INSTANCE_NAME=$1

clear
echo -e "\n"

echo -e "AWS Instance Management Program\n"
sleep 1

if [ -z "${INSTANCE_NAME}" ]; then

  echo "No Action Specified"
 #exit 1

fi

COMPONENTS=(frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment)

for comp in ${COMPONENTS[*]} ; do

  echo "Started Setting Up $comp"

  echo "End of $comp Setup"

done
