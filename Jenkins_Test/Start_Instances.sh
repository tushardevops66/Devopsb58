#!/bin/bash

#Function to Start an Instance which is in Stopped state

Start_Instances() {

	echo -e "\n List of Stopped Instances\n"
	aws ec2 describe-instances --filters  "Name=instance-state-name,Values=stopped" --query 'Reservations[].Instances[].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,Status:State.Name}' --output table

	read -p  "\n Mention the Instance Id from the below list should be Started : " START_INSTANCE

	aws ec2 start-instances --instance-ids $START_INSTANCE
	sleep 3

	echo -e "\n Checking if mentioned Instance has Started \n"
	sleep 3

	aws ec2 describe-instances --filters  "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].{Instance:InstanceId,AZ:Placement.    AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,Status:State.Name}' --output table
}
