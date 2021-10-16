
#!/bin/bash

List_Instances() {

	echo 
	echo -e "List of Instances is as follows: \n"
	aws ec2 describe-instances --filters Name=tag-key,Values=Name --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,Status:State.Name}' --output table 
}
