#! /bin/bash
DIR="/home/vsimrti"

if [ "$(ls -A $DIR)" ]; then
echo "empty"
else 
mv /home/vsimrti-allinone/vsimrti/* /home/vsimrti
chown 1000:1000 /home/vsimrti
fi
top -b
