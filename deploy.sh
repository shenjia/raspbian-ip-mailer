#!/bin/bash

. /lib/lsb/init-functions

log_action_msg Install ip-mailer \( by zshenjia@gmail.com \) ...

SCRIPT_FILE=ip-mailer.py
SCRIPT_PATH=/usr/local/bin
INIT_FILE=ip-mailer
INIT_PATH=/etc/init.d

sudo wget https://raw.github.com/shenjia/raspbian-ip-mailer/master/ip-mailer.py -O $SCRIPT_PATH/$SCRIPT_FILE
sudo wget https://raw.github.com/shenjia/raspbian-ip-mailer/master/ip-mailer -O $INIT_PATH/$INIT_FILE

sudo chmod +x $SCRIPT_PATH/$SCRIPT_FILE $INIT_PATH/$INIT_FILE
sudo update-rc.d $INIT_FILE defaults

log_success_msg Deploy ip-mailer ...
log_action_msg Don\'t forget to setup your Gmail account in \[ $SCRIPT_PATH/$SCRIPT_FILE \]
