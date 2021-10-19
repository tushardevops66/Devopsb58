#!/bin/bash

#Spot Instance Creation Script for Jenkins

#Function to Create a New AWS Spot Instance
Create_New_Spot_Instance() {
	echo "Creating the Instance : $COMPONENT"
	IP=$(aws ec2 run-instances --launch-template LaunchTemplateId=${LaunchTemplate_ID},Version=$Default \
        --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$COMPONENT}]" "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]")
        echo $IP
}

if [ -z "$COMPONENT" ]; then
        echo "Input is Missing!"
        exit 1
else
        echo "Calling the Create New Spot Instance Function"
        Create_New_Spot_Instance
        exit 0
fi 
