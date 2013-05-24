#!/usr/bin/python
import os
import subprocess
import smtplib
import socket
import datetime
import time
from email.mime.text import MIMEText

def start( action ):
    os.system( '. /lib/lsb/init-functions; log_begin_msg "' + action  + ' ..."' );
def success():
    os.system( '. /lib/lsb/init-functions; log_progress_msg done; log_end_msg 0');
def fail():
    os.system( '. /lib/lsb/init-functions; log_end_msg 1');

# Mail server settings
smtp_server = 'smtp.gmail.com'
smtp_port = 587

# Mail account settings
send_to = 'username@gmail.com'
mail_user = 'username@gmail.com'
mail_password = 'password'

# Connect to smtp server, try several times
start( 'Connect to [ ' + smtp_server + ' ]' )
try_max = 5
try_times = 0
try_delay = 1
while try_times <= try_max:
    try_times += 1
    try:
        smtpserver = smtplib.SMTP( smtp_server, smtp_port )
        success()
        break
    except Exception, what:
        if try_times > try_max:
            fail()
            exit()
        else:
            time.sleep( try_delay )
            try_delay *= 2

# Login to mail system
start( 'Login with ( ' + mail_user + ' )' )
try:
    smtpserver.ehlo()
    smtpserver.starttls()
    smtpserver.login( mail_user, mail_password )
    success()
except Exception, what:
    fail()
    exit()

# Build ip mail and send (for Raspberry only)
today = datetime.date.today()
p = subprocess.Popen( 'ip route list', shell = True, stdout = subprocess.PIPE )
data = p.communicate()
split_data = data[ 0 ].split()
ipaddr = split_data[ split_data.index( 'src' ) + 1 ]
my_ip = 'Your ip is %s' % ipaddr
start( 'Send ip mail ( ' + ipaddr + ' )' )
msg = MIMEText( my_ip )
msg[ 'Subject' ] = 'IP For RaspberryPi on %s' % today.strftime('%b %d %Y')
msg[ 'From' ] = mail_user
msg[ 'To' ] = send_to
try:
    smtpserver.sendmail( mail_user, [send_to], msg.as_string() )
    success()
except Exception, what:
    fail()
smtpserver.quit()
