
#!/bin/bash

#Function to display the Help 

source /home/centos/Devopsb58/Create_New_Instance.sh
source /home/centos/Devopsb58/list_instances.sh

LaunchTemplate_ID="lt-087cba96cb22f8769"

help() {
	echo
	echo "Pass the Details of the Action to be performed. Read the Below Help for Reference"
	echo -e "\n"
	echo "Enter the Number Value of the Action from the Below List"
	echo -e "\n 1) Create A New EC2 Instance \t\t 2) List Running EC2 Instance(s)"
}

#Executon starts here
clear
echo -e "\n"
echo -e "AWS Instance Management Program\n"
sleep 1
help
echo
read -p "Action Value :" ACTION_ID
#read -p "Specify the Instance name : " INSTANCE_NAME

if [ -z "${ACTION_ID}" ]; then

	echo
	echo -e "Exiting the AWS Instance management Program as - No Action Specified\n"
	exit 1
fi

#Creating a New EC2 Instance

if [ "${ACTION_ID}" = 1 ]; then

	Create_New_Spot_Instance

fi

if [ "${ACTION_ID}" = 2 ]; then
	
	echo
	echo "Checking for Details of Available Instances"
	List_Instances
fi

