#! /bin/bash

#Function to Stop a Running AWS Instance

Stop_Instances() {

		aws ec2 stop-instances --instance-ids ${INSTANCE_ID}
	
}

#Function to Check the Instance ID

Check_Instance_Id() {
	
	if [ "$INSTANCE_ID" = i-062dfff880656e1fc ]; then
		echo
		echo -e "This is the Main Instance and cannot be Stopped.\n"
		read -p  "Choose Another Instance ID to Stop (Enter 0 to Exit) : " New_Inst_ID
		List_Stop_Instances
	else
		Stop_Instances
	fi	
}


#Function to List Running Instances

List_Stop_Instances() {

	echo "List of Instances which are Currently Running/Pending"
	echo

	aws ec2 describe-instances --filters  "Name=instance-state-name,Values=pending,running" --query 'Reservations[].Instances[].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,Status:State.Name}' --output table
	echo
	read -p "Mention the Instance ID which needs to be Stopped (Enter 0 to Exit): " INSTANCE_ID
	echo
	if [ "$INSTANCE_ID" = 0 ]; then
		exit
	else
		Check_Instance_Id
	fi
}
