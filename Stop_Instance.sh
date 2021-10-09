#! /bin/bash

Function to Stop a Running AWS Instance

Stop_Instances() {

	IP={(aws ec2 describe-instances --filters Values=running

}
