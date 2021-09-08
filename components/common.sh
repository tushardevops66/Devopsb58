#!/bin/bash 

Status_Check() {
  if [ $1 -eq 0 ]; then 
    echo -e "\e[32mSUCCESS\e[0m"
  else 
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi 
}

Print() {
  echo -e "\n\t\t\e[36m----------------- $1 ----------------------\e[0m\n" >>$LOG
  echo -n -e "$1 \t- "
}

if [ $UID -ne 0 ]; then 
  echo -e "\n\e[1;33mYou should execute this script as root User\e[0m\n"
  exit 1
fi 

LOG=/tmp/roboshop.log 
rm -f $LOG

ADD_APP_USER() {
  Print "Adding RoboShop User\t"
  id roboshop &>>$LOG
  if [ $? -eq 0 ]; then
    echo "User already there, So Skipping" &>>$LOG
  else
    useradd roboshop &>>$LOG
  fi
  Status_Check $?
}

DOWNLOAD() {
  Print "Downloading ${COMPONENT} Content"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  Status_Check $?
  Print "Extracting ${COMPONENT}\t"
  cd /home/roboshop
  rm -rf ${COMPONENT} && unzip -o /tmp/${COMPONENT}.zip &>>$LOG && mv ${COMPONENT}-main ${COMPONENT}
  Status_Check $?
}

SystemdD_Setup() {
  Print "Update SystemD Service\t"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e  's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service
  Status_Check $?

  Print "Setup SystemD Service\t"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service && systemctl daemon-reload && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  Status_Check $?
}

NODEJS() {
  Print "Installing NodeJS\t"
  yum install nodejs make gcc-c++ -y &>>$LOG
  Status_Check $?
  ADD_APP_USER
  DOWNLOAD
  Print "Download NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install --unsafe-perm &>>$LOG
  Status_Check $?
  chown roboshop:roboshop -R /home/roboshop
  SystemdD_Setup
}