mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

sudo -i
echo "
# Configuration file for my watchlog service
# Place it to /etc/sysconfig

# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
" > /etc/sysconfig/watchlog

echo "ALERT" > /var/log/watchlog.log


echo "
#!/bin/bash

WORD=$1
LOG=$2
DATE=`date`

if grep $WORD $LOG &> /dev/null
then
logger "$DATE: I found word, Master!"
else
exit 0
fi
" > /opt/watchlog.sh

chmod +x /opt/watchlog.sh

echo "
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh $WORD $LOG
" > /etc/systemd/system/watchlog.service

echo "
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/watchlog.timer $$ systemctl start watchlog.timer
sleep 40 
tail -n 10 /var/log/messages | grep Master

