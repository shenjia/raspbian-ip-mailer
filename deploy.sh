#!/bin/bash

. /lib/lsb/init-functions

# Settings
SCRIPT_FILE=raspbian-ip-mailer.py
SCRIPT_PATH=/usr/local/bin
LAUNCHER_FILE=raspbian-ip-mailer
LAUNCHER_PATH=/etc/init.d

log_action_msg Installing [ raspbian-ip-mailer ] \( by zshenjia@gmail.com \) ...

# Download script
log_begin_msg Downloading [ $SCRIPT_FILE ] from Github to [ $SCRIPT_PATH ]...
sudo wget https://raw.github.com/shenjia/raspbian-ip-mailer/master/$SCRIPT_FILE -O $SCRIPT_PATH/$SCRIPT_FILE -o /dev/null
log_end_msg $?

# Download laucher
log_begin_msg Downloading [ $LAUNCHER_FILE ] from Github to [ $LAUNCHER_PATH ]...
sudo wget https://raw.github.com/shenjia/raspbian-ip-mailer/master/$LAUNCHER_FILE -O $LAUNCHER_PATH/$LAUNCHER_FILE  -o /dev/null
log_end_msg $?

# Deploy
log_begin_msg Deploying [ $LAUNCHER_FILE ] as service ...  
sudo chmod +x $SCRIPT_PATH/$SCRIPT_FILE $LAUNCHER_PATH/$LAUNCHER_FILE
sudo update-rc.d $LAUNCHER_FILE defaults >> /dev/null
log_end_msg $?

# Done
log_action_msg Done! Don\'t forget to setup your Gmail account in \[ $SCRIPT_PATH/$SCRIPT_FILE \]

