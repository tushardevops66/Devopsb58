#!/bin/bash

#Function to Create a New AWS Spot Instance
Create_New_Spot_Instance() {
	read -p "Specify the Instance name : " INSTANCE_NAME
	IP=$(aws ec2 run-instances --launch-template LaunchTemplateId=${LaunchTemplate_ID},Version=$Default \
        --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]")
        echo $IP
}

